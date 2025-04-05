use crate::api::{ErrorType, Events, ServerConfig, TUpdate, Value};
use crate::frb_generated::StreamSink;
use crate::wormhole::handler::{gen_handler_dummy, gen_progress_handler, gen_transit_handler};
use crate::wormhole::helpers::{gen_app_config, gen_relay_hints};
use async_std::fs::OpenOptions;
use magic_wormhole::{
    transfer, transit, Code, MailboxConnection, Wormhole,
};
use std::path::{Path, PathBuf};
use std::rc::Rc;

pub async fn request_file(
    raw_code: String,
    storage_folder: String,
    server_config: ServerConfig,
    actions: StreamSink<TUpdate>,
) {
    let actions = Rc::new(actions);

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

    let code_res: Result<Code, _> = raw_code.parse();
    let code: Code = match code_res {
        Ok(code) => code,
        Err(e) => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::ErrorValue(ErrorType::ParseCodeError, e.to_string()),
            ));
            return;
        }
    };

    let mailbox_connection = match MailboxConnection::connect(appconfig, code, true).await {
        Ok(v) => v,
        Err(e) => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::ErrorValue(ErrorType::ConnectionError, e.to_string()),
            ));
            return;
        }
    };

    let wormhole = match Wormhole::connect(mailbox_connection).await {
        Ok(v) => v,
        Err(e) => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::ErrorValue(ErrorType::FileRequestError, e.to_string()),
            ));
            return;
        }
    };

    let req = match transfer::request_file(
        wormhole,
        relay_hints,
        transit::Abilities::ALL,
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

    let file_name = req.file_name();

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
        Value::String(file_path.to_str().unwrap_or_default().to_string()),
    ));
}

/// find next free filepath on fs (padding with (copy))
fn find_free_filepath(path: PathBuf) -> Option<PathBuf> {
    // if path is free terminate recursion
    if !path.exists() {
        return Some(path);
    }

    // get extension or empty string if no one exists
    let ext = path.extension().and_then(|x| x.to_str()).unwrap_or("");

    match path.file_stem().and_then(|x| x.to_str()) {
        None => None,
        Some(v) => {
            let name = if ext.is_empty() {
                format!("{}(copy)", v)
            } else {
                format!("{}(copy).{}", v, ext)
            };
            let mut path = path.clone();
            path.set_file_name(name.as_str());
            // recursively call this function until a free path is found
            find_free_filepath(path.to_path_buf())
        }
    }
}
