/// Entrypoint of Wormhole Rust backend
use crate::impls::receive::request_file_impl;
use crate::impls::send::send_file_impl;
use flutter_rust_bridge::StreamSink;
use futures::executor::block_on;
use macros::{build_time, version_str};
use magic_wormhole::Code;

pub enum Events {
    /// Passphrase : String
    Code,
    /// Total bytes to transfer : i32
    Total,
    /// bytes already sent : i32
    Sent,
    /// error : Error or ErrorValue
    Error,
    /// transfer finished : String
    Finished,
    /// type of con : Connectiontype
    ConnectionType,
    /// indicate start of transaction : i32
    StartTransfer,
}

pub enum Value {
    /// Integer value
    Int(i32),
    /// String value
    String(String),
    /// Error value with message
    ErrorValue(ErrorType, String),
    /// Plain error
    Error(ErrorType),
    /// Type of connection with corresponding ip/url
    ConnectionType(ConnectionType, String),
}

pub enum ConnectionType {
    Relay,
    Direct,
}

pub enum ErrorType {
    /// user passed invalid filepath
    InvalidFilename,
    /// no free filepath could be found
    NoFilePathFound,
    /// failed connecting to rendezvous server
    ConnectionError,
    /// error while requesting a file transfer
    FileRequestError,
    /// error while opening the receive file
    FileOpen,
    /// error during file transfer
    TransferError,
    /// error while connecting clients
    TransferConnectionError,
}

pub struct TUpdate {
    pub event: Events,
    pub value: Value,
}

impl TUpdate {
    pub fn new(event: Events, value: Value) -> TUpdate {
        TUpdate { event, value }
    }
}

pub struct BuildInfo {
    pub build_time: u64,
    pub dev_build: bool,
    pub version: String,
}

pub fn send_file(
    file_name: String,
    file_path: String,
    code_length: u8,
    actions: StreamSink<TUpdate>,
) {
    block_on(async {
        send_file_impl(file_name, file_path, code_length, actions).await;
    });
}

pub fn request_file(passphrase: String, storage_folder: String, actions: StreamSink<TUpdate>) {
    block_on(async {
        request_file_impl(passphrase, storage_folder, actions).await;
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
    BuildInfo {
        build_time: build_time!(),
        dev_build: cfg!(debug_assertions),
        version: version_str!().to_string(),
    }
}
