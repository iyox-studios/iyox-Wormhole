use crate::api::{ErrorType, Events, TUpdate, Value};
use crate::impls::handler::{gen_handler_dummy, gen_progress_handler, gen_transit_handler};
use crate::impls::helpers::{gen_app_config, gen_relay_hints};
use crate::impls::path::find_free_filepath;
use async_std::fs::OpenOptions;
use flutter_rust_bridge::StreamSink;
use magic_wormhole::{transfer, transit, Code, Wormhole};
use std::path::Path;
use std::rc::Rc;

pub async fn request_file_impl(
    passphrase: String,
    storage_folder: String,
    actions: StreamSink<TUpdate>,
) {
    let actions = Rc::new(actions);

    let relay_hints = gen_relay_hints();
    let appconfig = gen_app_config();

    let (_, wormhole) = match Wormhole::connect_with_code(appconfig, Code(passphrase)).await {
        Ok(v) => v,
        Err(e) => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::ErrorValue(ErrorType::ConnectionError, e.to_string()),
            ));
            return;
        }
    };

    let req = match transfer::request_file(
        wormhole,
        relay_hints,
        transit::Abilities::ALL_ABILITIES,
        gen_handler_dummy(),
    )
    .await
    {
        Ok(v) => v,
        Err(e) => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::ErrorValue(ErrorType::FileRequestError, e.to_string()),
            ));
            return;
        }
    };

    /* If None, the task got cancelled */
    let req = match req {
        Some(req) => req,
        None => return,
    };

    /*
     * Control flow is a bit tricky here:
     * - First of all, we ask if we want to receive the file at all
     * - Then, we check if the file already exists
     * - If it exists, ask whether to overwrite and act accordingly
     * - If it doesn't, directly accept, but DON'T overwrite any files
     */

    let file_name = match req.filename.file_name() {
        None => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::Error(ErrorType::InvalidFilename),
            ));
            return;
        }
        Some(v) => v,
    };

    let file_path = Path::new(storage_folder.as_str()).join(file_name);
    let file_path = match find_free_filepath(file_path) {
        None => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::Error(ErrorType::NoFilePathFound),
            ));
            return;
        }
        Some(s) => s,
    };

    /* Then, accept if the file exists */
    let mut file = match OpenOptions::new()
        .write(true)
        .create_new(true)
        .open(&file_path)
        .await
    {
        Ok(v) => v,
        Err(e) => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::ErrorValue(ErrorType::FileOpen, e.to_string()),
            ));
            return;
        }
    };

    let on_progress = gen_progress_handler(Rc::clone(&actions));
    let transit_handler = gen_transit_handler(Rc::clone(&actions));

    match req
        .accept(transit_handler, on_progress, &mut file, gen_handler_dummy())
        .await
    {
        Ok(_) => {}
        Err(e) => {
            // todo better handling
            actions.add(TUpdate::new(
                Events::Error,
                Value::ErrorValue(ErrorType::TransferError, e.to_string()),
            ));
            return;
        }
    }
    actions.add(TUpdate::new(
        Events::Finished,
        Value::String(file_path.to_str().unwrap().to_string()),
    ));
}
