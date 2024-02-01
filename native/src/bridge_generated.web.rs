use super::*;
// Section: wire functions

#[wasm_bindgen]
pub fn wire_init(port_: MessagePort, temp_file_path: String) {
    wire_init_impl(port_, temp_file_path)
}

#[wasm_bindgen]
pub fn wire_send_files(
    port_: MessagePort,
    file_paths: JsValue,
    name: String,
    code_length: u8,
    server_config: JsValue,
) {
    wire_send_files_impl(port_, file_paths, name, code_length, server_config)
}

#[wasm_bindgen]
pub fn wire_send_folder(
    port_: MessagePort,
    folder_path: String,
    name: String,
    code_length: u8,
    server_config: JsValue,
) {
    wire_send_folder_impl(port_, folder_path, name, code_length, server_config)
}

#[wasm_bindgen]
pub fn wire_request_file(
    port_: MessagePort,
    passphrase: String,
    storage_folder: String,
    server_config: JsValue,
) {
    wire_request_file_impl(port_, passphrase, storage_folder, server_config)
}

#[wasm_bindgen]
pub fn wire_get_passphrase_uri(
    port_: MessagePort,
    passphrase: String,
    rendezvous_server: Option<String>,
) {
    wire_get_passphrase_uri_impl(port_, passphrase, rendezvous_server)
}

#[wasm_bindgen]
pub fn wire_get_build_time(port_: MessagePort) {
    wire_get_build_time_impl(port_)
}

#[wasm_bindgen]
pub fn wire_default_rendezvous_url(port_: MessagePort) {
    wire_default_rendezvous_url_impl(port_)
}

#[wasm_bindgen]
pub fn wire_default_transit_url(port_: MessagePort) {
    wire_default_transit_url_impl(port_)
}

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for String {
    fn wire2api(self) -> String {
        self
    }
}
impl Wire2Api<Vec<String>> for JsValue {
    fn wire2api(self) -> Vec<String> {
        self.dyn_into::<JsArray>()
            .unwrap()
            .iter()
            .map(Wire2Api::wire2api)
            .collect()
    }
}

impl Wire2Api<Option<String>> for Option<String> {
    fn wire2api(self) -> Option<String> {
        self.map(Wire2Api::wire2api)
    }
}
impl Wire2Api<ServerConfig> for JsValue {
    fn wire2api(self) -> ServerConfig {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        ServerConfig {
            rendezvous_url: self_.get(0).wire2api(),
            transit_url: self_.get(1).wire2api(),
        }
    }
}

impl Wire2Api<Vec<u8>> for Box<[u8]> {
    fn wire2api(self) -> Vec<u8> {
        self.into_vec()
    }
}
// Section: impl Wire2Api for JsValue

impl<T> Wire2Api<Option<T>> for JsValue
where
    JsValue: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null() && !self.is_undefined()).then(|| self.wire2api())
    }
}
impl Wire2Api<String> for JsValue {
    fn wire2api(self) -> String {
        self.as_string().expect("non-UTF-8 string, or not a string")
    }
}
impl Wire2Api<u8> for JsValue {
    fn wire2api(self) -> u8 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<Vec<u8>> for JsValue {
    fn wire2api(self) -> Vec<u8> {
        self.unchecked_into::<js_sys::Uint8Array>().to_vec().into()
    }
}
