use crate::api::{ErrorType, Events, ServerConfig, TUpdate, Value};
use crate::wormhole::handler::{gen_handler_dummy, gen_progress_handler, gen_transit_handler};
use crate::wormhole::helpers::{gen_app_config, gen_relay_hints};
use crate::wormhole::zip::create_zip_file;
use flutter_rust_bridge::StreamSink;
use magic_wormhole::transfer::TransferError;
use magic_wormhole::{transfer, transit, Wormhole};
use std::collections::HashMap;
use std::fs::remove_file;
use std::rc::Rc;

pub async fn send_files_impl(
    name: String,
    files: HashMap<String, String>,
    code_length: u8,
    temp_file_path: String,
    server_config: ServerConfig,
    actions: Rc<StreamSink<TUpdate>>,
) {
    let temp_file = match create_zip_file(files, temp_file_path, actions.clone()) {
        Ok(v) => v,
        Err(e) => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::ErrorValue(ErrorType::ZipFileError, e.to_string()),
            ));
            return;
        }
    };

    send_file_impl(
        format!("{}.zip", name),
        temp_file.clone(),
        code_length,
        server_config,
        actions,
    )
    .await;

    // remove generated temp file
    let _ = remove_file(temp_file);
}

pub async fn send_file_impl(
    file_name: String,
    file_path: String,
    code_length: u8,
    server_config: ServerConfig,
    actions: Rc<StreamSink<TUpdate>>,
) {
    // push event that we are in connection state
    actions.add(TUpdate::new(Events::Connecting, Value::Int(0)));

    let relay_hints = match gen_relay_hints(&server_config) {
        Ok(v) => v,
        Err(_) => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::Error(ErrorType::ConnectionError),
            ));
            return;
        }
    };
    let appconfig = gen_app_config(&server_config);

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
