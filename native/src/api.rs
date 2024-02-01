/// Entrypoint of Wormhole Rust backend
use crate::wormhole::receive::request_file_impl;
use crate::wormhole::send::{send_file_impl, send_files_impl};
use crate::wormhole::zip::list_dir;
use flutter_rust_bridge::StreamSink;
use futures::executor::block_on;
use magic_wormhole::rendezvous::DEFAULT_RENDEZVOUS_SERVER;
use magic_wormhole::{transit, Code};
use std::cmp::Ordering;
use std::collections::HashMap;
use std::path::PathBuf;
use std::rc::Rc;
use std::string::ToString;
use std::sync::Mutex;

// make types neccessary for api visible
pub use crate::wormhole::types::build_info::BuildInfo;
pub use crate::wormhole::types::error_types::ErrorType;
pub use crate::wormhole::types::events::Events;
pub use crate::wormhole::types::t_update::TUpdate;
pub use crate::wormhole::types::value::{ConnectionType, Value};

/// Keep a global temp file path reference
static TEMP_FILE_PATH: Mutex<Option<String>> = Mutex::new(None);

/// initialize backend api
pub fn init(temp_file_path: String) {
    *TEMP_FILE_PATH.lock().unwrap() = Some(temp_file_path);
}

pub struct ServerConfig {
    pub rendezvous_url: String,
    pub transit_url: String,
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
                send_file_impl(
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
                send_files_impl(name, files, code_length, temp_dir, server_config, actions).await;
            });
        }
    }
}

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
            actions.add(TUpdate::new(
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
        send_files_impl(
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

pub fn request_file(
    passphrase: String,
    storage_folder: String,
    server_config: ServerConfig,
    actions: StreamSink<TUpdate>,
) {
    block_on(async {
        request_file_impl(passphrase, storage_folder, server_config, actions).await;
    });
}

pub fn get_passphrase_uri(passphrase: String, rendezvous_server: Option<String>) -> String {
    let url = rendezvous_server.and_then(|a| url::Url::parse(a.as_str()).ok());

    magic_wormhole::uri::WormholeTransferUri {
        code: Code(passphrase),
        rendezvous_server: url,
        is_leader: false,
    }
    .to_string()
}

pub fn get_build_time() -> BuildInfo {
    BuildInfo::new()
}

pub fn default_rendezvous_url() -> String {
    DEFAULT_RENDEZVOUS_SERVER.to_string()
}

pub fn default_transit_url() -> String {
    transit::DEFAULT_RELAY_SERVER.to_string()
}
