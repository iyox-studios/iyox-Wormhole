use std::cmp::Ordering;
use std::collections::HashMap;
use std::path::PathBuf;
use std::rc::Rc;
use std::sync::Mutex;

use futures::executor::block_on;
use magic_wormhole::rendezvous::DEFAULT_RENDEZVOUS_SERVER;
use magic_wormhole::transit;

use crate::frb_generated::StreamSink;
use crate::wormhole::{receive, send};
pub use crate::wormhole::types::error_types::ErrorType;
pub use crate::wormhole::types::events::Events;
pub use crate::wormhole::types::t_update::TUpdate;
pub use crate::wormhole::types::value::Value;

pub struct ServerConfig {
    pub rendezvous_url: String,
    pub transit_url: String,
}

/// Keep a global temp file path reference
static TEMP_FILE_PATH: Mutex<Option<String>> = Mutex::new(None);

/// initialize backend api
#[flutter_rust_bridge::frb(init)]
pub fn init() {
    flutter_rust_bridge::setup_default_user_utils();
}

#[flutter_rust_bridge::frb(sync)]
pub fn init_backend(temp_file_path: String) {
    *TEMP_FILE_PATH.lock().unwrap() = Some(temp_file_path);
}

pub fn send_files(
    file_paths: Vec<String>,
    name: String,
    code_length: u8,
    server_config: ServerConfig,
    actions: StreamSink<TUpdate>,
) {
    let actions = Rc::new(actions);

    match file_paths.len().cmp(&1) {
        Ordering::Less => {
            actions.add(TUpdate::new(
                Events::Error,
                Value::Error(ErrorType::InvalidFilename),
                // todo proper error message
            ));
        }
        Ordering::Equal => {
            block_on(async {
                send::send_file(
                    name,
                    file_paths[0].to_string(),
                    code_length,
                    server_config,
                    actions,
                )
                .await;
            });
        }
        Ordering::Greater => {
            let files: HashMap<String, String> = file_paths
                .iter()
                .map(|x| {
                    (
                        x.to_string(),
                        PathBuf::from(x)
                            .file_name()
                            .unwrap_or_default()
                            .to_str()
                            .unwrap_or_default()
                            .to_string(),
                    )
                })
                .collect();
            let temp_dir = TEMP_FILE_PATH
                .lock()
                .unwrap()
                .clone()
                .expect("set temp file func not called");
            block_on(async {
                send::send_files(name, files, code_length, temp_dir, server_config, actions).await;
            });
        }
    }
}

/* Zipping a folder currently needs to by handled by dart
pub fn send_folder(
    folder_path: String,
    name: String,
    code_length: u8,
    server_config: ServerConfig,
    actions: StreamSink<TUpdate>,
) {
    let files = match list_dir(folder_path) {
        Ok(v) => v,
        Err(_) => {
            let _ = actions.add(TUpdate::new(
                Events::Error,
                Value::Error(ErrorType::InvalidFilename),
                // todo proper error message
            ));
            return;
        }
    };

    let temp_dir = TEMP_FILE_PATH
        .lock()
        .unwrap()
        .clone()
        .expect("set temp file func not called");

    block_on(async {
        send::send_files(
            name,
            files,
            code_length,
            temp_dir,
            server_config,
            Rc::new(actions),
        )
        .await;
    });
}
*/

pub fn request_file(
    code: String,
    storage_folder: String,
    server_config: ServerConfig,
    actions: StreamSink<TUpdate>,
) {
    block_on(async {
        receive::request_file(code, storage_folder, server_config, actions).await;
    });
}

/* TODO
pub fn get_passphrase_uri(passphrase: String, rendezvous_server: Option<String>) -> String {
    let url = rendezvous_server.and_then(|a| url::Url::parse(a.as_str()).ok());

    magic_wormhole::uri::WormholeTransferUri {
        code: Code(passphrase),
        rendezvous_server: url,
        is_leader: false,
    }
    .to_string()
}
*/

#[flutter_rust_bridge::frb(sync)]
pub fn default_rendezvous_url() -> String {
    DEFAULT_RENDEZVOUS_SERVER.to_string()
}

#[flutter_rust_bridge::frb(sync)]
pub fn default_transit_url() -> String {
    transit::DEFAULT_RELAY_SERVER.to_string()
}
