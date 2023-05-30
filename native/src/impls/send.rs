use crate::api::{ErrorType, Events, TUpdate, Value};
use crate::impls::handler::{gen_handler_dummy, gen_progress_handler, gen_transit_handler};
use crate::impls::helpers::{gen_app_config, gen_relay_hints};
use flutter_rust_bridge::StreamSink;
use magic_wormhole::transfer::TransferError;
use magic_wormhole::{transfer, transit, Wormhole};
use std::rc::Rc;

pub async fn send_file_impl(
    file_name: String,
    file_path: String,
    code_length: u8,
    actions: StreamSink<TUpdate>,
) {
    let actions = Rc::new(actions);

    let relay_hints = gen_relay_hints();
    let appconfig = gen_app_config();

    let (server_welcome, connector) =
        match Wormhole::connect_without_code(appconfig, code_length as usize).await {
            Ok(v) => v,
            Err(e) => {
                actions.add(TUpdate::new(
                    Events::Error,
                    Value::ErrorValue(ErrorType::ConnectionError, e.to_string()),
                ));
                return;
            }
        };

    let code = server_welcome.code;
    actions.add(TUpdate::new(Events::Code, Value::String(code.clone().0)));

    let wormhole = match connector.await {
        Ok(v) => v,
        Err(e) => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::ErrorValue(ErrorType::TransferConnectionError, e.to_string()),
            ));
            return;
        }
    };

    match Box::pin(send(
        wormhole,
        relay_hints,
        file_path.as_str(),
        file_name.as_str(),
        transit::Abilities::ALL_ABILITIES,
        Rc::clone(&actions),
    ))
    .await
    {
        Ok(_) => (),
        Err(e) => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::ErrorValue(ErrorType::TransferError, e.to_string()),
            ));
            return;
        }
    };
    actions.add(TUpdate::new(Events::Finished, Value::String(file_name)));
}

async fn send(
    wormhole: Wormhole,
    relay_hints: Vec<transit::RelayHint>,
    file_path: &str,
    file_name: &str,
    transit_abilities: transit::Abilities,
    actions: Rc<StreamSink<TUpdate>>,
) -> Result<(), TransferError> {
    let handler = gen_handler_dummy();
    let transit_handler = gen_transit_handler(Rc::clone(&actions));
    let progress_handler = gen_progress_handler(Rc::clone(&actions));

    transfer::send_file_or_folder(
        wormhole,
        relay_hints,
        file_path,
        file_name,
        transit_abilities,
        transit_handler,
        progress_handler,
        handler,
    )
    .await?;
    Ok(())
}
