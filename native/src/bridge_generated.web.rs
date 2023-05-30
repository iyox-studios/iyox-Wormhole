use super::*;
// Section: wire functions

#[wasm_bindgen]
pub fn wire_send_file(port_: MessagePort, file_name: String, file_path: String, code_length: u8) {
    wire_send_file_impl(port_, file_name, file_path, code_length)
}

#[wasm_bindgen]
pub fn wire_request_file(port_: MessagePort, passphrase: String, storage_folder: String) {
    wire_request_file_impl(port_, passphrase, storage_folder)
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
pub fn wire_new__static_method__TUpdate(port_: MessagePort, event: i32, value: JsValue) {
    wire_new__static_method__TUpdate_impl(port_, event, value)
}

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for String {
    fn wire2api(self) -> String {
        self
    }
}

impl Wire2Api<Option<String>> for Option<String> {
    fn wire2api(self) -> Option<String> {
        self.map(Wire2Api::wire2api)
    }
}

impl Wire2Api<Vec<u8>> for Box<[u8]> {
    fn wire2api(self) -> Vec<u8> {
        self.into_vec()
    }
}
impl Wire2Api<Value> for JsValue {
    fn wire2api(self) -> Value {
        let self_ = self.unchecked_into::<JsArray>();
        match self_.get(0).unchecked_into_f64() as _ {
            0 => Value::Int(self_.get(1).wire2api()),
            1 => Value::String(self_.get(1).wire2api()),
            2 => Value::ErrorValue(self_.get(1).wire2api(), self_.get(2).wire2api()),
            3 => Value::Error(self_.get(1).wire2api()),
            4 => Value::ConnectionType(self_.get(1).wire2api(), self_.get(2).wire2api()),
            _ => unreachable!(),
        }
    }
}
// Section: impl Wire2Api for JsValue

impl Wire2Api<String> for JsValue {
    fn wire2api(self) -> String {
        self.as_string().expect("non-UTF-8 string, or not a string")
    }
}
impl Wire2Api<ConnectionType> for JsValue {
    fn wire2api(self) -> ConnectionType {
        (self.unchecked_into_f64() as i32).wire2api()
    }
}
impl Wire2Api<ErrorType> for JsValue {
    fn wire2api(self) -> ErrorType {
        (self.unchecked_into_f64() as i32).wire2api()
    }
}
impl Wire2Api<Events> for JsValue {
    fn wire2api(self) -> Events {
        (self.unchecked_into_f64() as i32).wire2api()
    }
}
impl Wire2Api<i32> for JsValue {
    fn wire2api(self) -> i32 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<Option<String>> for JsValue {
    fn wire2api(self) -> Option<String> {
        (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
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
