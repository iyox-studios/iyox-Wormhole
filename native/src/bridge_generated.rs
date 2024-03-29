#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case,
    clippy::too_many_arguments
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.82.6.

use crate::api::*;
use core::panic::UnwindSafe;
use flutter_rust_bridge::rust2dart::IntoIntoDart;
use flutter_rust_bridge::*;
use std::ffi::c_void;
use std::sync::Arc;

// Section: imports

use crate::wormhole::types::build_info::BuildInfo;
use crate::wormhole::types::error_types::ErrorType;
use crate::wormhole::types::events::Events;
use crate::wormhole::types::t_update::TUpdate;
use crate::wormhole::types::value::ConnectionType;
use crate::wormhole::types::value::Value;

// Section: wire functions

fn wire_init_impl(port_: MessagePort, temp_file_path: impl Wire2Api<String> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "init",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_temp_file_path = temp_file_path.wire2api();
            move |task_callback| Result::<_, ()>::Ok(init(api_temp_file_path))
        },
    )
}
fn wire_send_files_impl(
    port_: MessagePort,
    file_paths: impl Wire2Api<Vec<String>> + UnwindSafe,
    name: impl Wire2Api<String> + UnwindSafe,
    code_length: impl Wire2Api<u8> + UnwindSafe,
    server_config: impl Wire2Api<ServerConfig> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "send_files",
            port: Some(port_),
            mode: FfiCallMode::Stream,
        },
        move || {
            let api_file_paths = file_paths.wire2api();
            let api_name = name.wire2api();
            let api_code_length = code_length.wire2api();
            let api_server_config = server_config.wire2api();
            move |task_callback| {
                Result::<_, ()>::Ok(send_files(
                    api_file_paths,
                    api_name,
                    api_code_length,
                    api_server_config,
                    task_callback.stream_sink::<_, TUpdate>(),
                ))
            }
        },
    )
}
fn wire_send_folder_impl(
    port_: MessagePort,
    folder_path: impl Wire2Api<String> + UnwindSafe,
    name: impl Wire2Api<String> + UnwindSafe,
    code_length: impl Wire2Api<u8> + UnwindSafe,
    server_config: impl Wire2Api<ServerConfig> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "send_folder",
            port: Some(port_),
            mode: FfiCallMode::Stream,
        },
        move || {
            let api_folder_path = folder_path.wire2api();
            let api_name = name.wire2api();
            let api_code_length = code_length.wire2api();
            let api_server_config = server_config.wire2api();
            move |task_callback| {
                Result::<_, ()>::Ok(send_folder(
                    api_folder_path,
                    api_name,
                    api_code_length,
                    api_server_config,
                    task_callback.stream_sink::<_, TUpdate>(),
                ))
            }
        },
    )
}
fn wire_request_file_impl(
    port_: MessagePort,
    passphrase: impl Wire2Api<String> + UnwindSafe,
    storage_folder: impl Wire2Api<String> + UnwindSafe,
    server_config: impl Wire2Api<ServerConfig> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "request_file",
            port: Some(port_),
            mode: FfiCallMode::Stream,
        },
        move || {
            let api_passphrase = passphrase.wire2api();
            let api_storage_folder = storage_folder.wire2api();
            let api_server_config = server_config.wire2api();
            move |task_callback| {
                Result::<_, ()>::Ok(request_file(
                    api_passphrase,
                    api_storage_folder,
                    api_server_config,
                    task_callback.stream_sink::<_, TUpdate>(),
                ))
            }
        },
    )
}
fn wire_get_passphrase_uri_impl(
    port_: MessagePort,
    passphrase: impl Wire2Api<String> + UnwindSafe,
    rendezvous_server: impl Wire2Api<Option<String>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "get_passphrase_uri",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_passphrase = passphrase.wire2api();
            let api_rendezvous_server = rendezvous_server.wire2api();
            move |task_callback| {
                Result::<_, ()>::Ok(get_passphrase_uri(api_passphrase, api_rendezvous_server))
            }
        },
    )
}
fn wire_get_build_time_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, BuildInfo, _>(
        WrapInfo {
            debug_name: "get_build_time",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(get_build_time()),
    )
}
fn wire_default_rendezvous_url_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "default_rendezvous_url",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(default_rendezvous_url()),
    )
}
fn wire_default_transit_url_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "default_transit_url",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(default_transit_url()),
    )
}
// Section: wrapper structs

// Section: static checks

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null()).then(|| self.wire2api())
    }
}

impl Wire2Api<u8> for u8 {
    fn wire2api(self) -> u8 {
        self
    }
}

// Section: impl IntoDart

impl support::IntoDart for BuildInfo {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.build_time.into_into_dart().into_dart(),
            self.dev_build.into_into_dart().into_dart(),
            self.version.into_into_dart().into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for BuildInfo {}
impl rust2dart::IntoIntoDart<BuildInfo> for BuildInfo {
    fn into_into_dart(self) -> Self {
        self
    }
}

impl support::IntoDart for ConnectionType {
    fn into_dart(self) -> support::DartAbi {
        match self {
            Self::Relay => 0,
            Self::Direct => 1,
        }
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for ConnectionType {}
impl rust2dart::IntoIntoDart<ConnectionType> for ConnectionType {
    fn into_into_dart(self) -> Self {
        self
    }
}

impl support::IntoDart for ErrorType {
    fn into_dart(self) -> support::DartAbi {
        match self {
            Self::InvalidFilename => 0,
            Self::NoFilePathFound => 1,
            Self::ConnectionError => 2,
            Self::FileRequestError => 3,
            Self::FileOpen => 4,
            Self::TransferError => 5,
            Self::TransferConnectionError => 6,
            Self::ZipFileError => 7,
        }
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for ErrorType {}
impl rust2dart::IntoIntoDart<ErrorType> for ErrorType {
    fn into_into_dart(self) -> Self {
        self
    }
}

impl support::IntoDart for Events {
    fn into_dart(self) -> support::DartAbi {
        match self {
            Self::Code => 0,
            Self::Total => 1,
            Self::Sent => 2,
            Self::Error => 3,
            Self::Connecting => 4,
            Self::Finished => 5,
            Self::ConnectionType => 6,
            Self::StartTransfer => 7,
            Self::ZipFilesTotal => 8,
            Self::ZipFiles => 9,
        }
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Events {}
impl rust2dart::IntoIntoDart<Events> for Events {
    fn into_into_dart(self) -> Self {
        self
    }
}

impl support::IntoDart for TUpdate {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.event.into_into_dart().into_dart(),
            self.value.into_into_dart().into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for TUpdate {}
impl rust2dart::IntoIntoDart<TUpdate> for TUpdate {
    fn into_into_dart(self) -> Self {
        self
    }
}

impl support::IntoDart for Value {
    fn into_dart(self) -> support::DartAbi {
        match self {
            Self::Int(field0) => vec![0.into_dart(), field0.into_into_dart().into_dart()],
            Self::String(field0) => vec![1.into_dart(), field0.into_into_dart().into_dart()],
            Self::ErrorValue(field0, field1) => vec![
                2.into_dart(),
                field0.into_into_dart().into_dart(),
                field1.into_into_dart().into_dart(),
            ],
            Self::Error(field0) => vec![3.into_dart(), field0.into_into_dart().into_dart()],
            Self::ConnectionType(field0, field1) => vec![
                4.into_dart(),
                field0.into_into_dart().into_dart(),
                field1.into_into_dart().into_dart(),
            ],
        }
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Value {}
impl rust2dart::IntoIntoDart<Value> for Value {
    fn into_into_dart(self) -> Self {
        self
    }
}

// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

/// cbindgen:ignore
#[cfg(target_family = "wasm")]
#[path = "bridge_generated.web.rs"]
mod web;
#[cfg(target_family = "wasm")]
pub use self::web::*;

#[cfg(not(target_family = "wasm"))]
#[path = "bridge_generated.io.rs"]
mod io;
#[cfg(not(target_family = "wasm"))]
pub use self::io::*;
