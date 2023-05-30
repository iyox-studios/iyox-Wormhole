use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_send_file(
    port_: i64,
    file_name: *mut wire_uint_8_list,
    file_path: *mut wire_uint_8_list,
    code_length: u8,
) {
    wire_send_file_impl(port_, file_name, file_path, code_length)
}

#[no_mangle]
pub extern "C" fn wire_request_file(
    port_: i64,
    passphrase: *mut wire_uint_8_list,
    storage_folder: *mut wire_uint_8_list,
) {
    wire_request_file_impl(port_, passphrase, storage_folder)
}

#[no_mangle]
pub extern "C" fn wire_get_passphrase_uri(
    port_: i64,
    passphrase: *mut wire_uint_8_list,
    rendezvous_server: *mut wire_uint_8_list,
) {
    wire_get_passphrase_uri_impl(port_, passphrase, rendezvous_server)
}

#[no_mangle]
pub extern "C" fn wire_get_build_time(port_: i64) {
    wire_get_build_time_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_new__static_method__TUpdate(port_: i64, event: i32, value: *mut wire_Value) {
    wire_new__static_method__TUpdate_impl(port_, event, value)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_box_autoadd_value_0() -> *mut wire_Value {
    support::new_leak_box_ptr(wire_Value::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}
impl Wire2Api<Value> for *mut wire_Value {
    fn wire2api(self) -> Value {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<Value>::wire2api(*wrap).into()
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
impl Wire2Api<Value> for wire_Value {
    fn wire2api(self) -> Value {
        match self.tag {
            0 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.Int);
                Value::Int(ans.field0.wire2api())
            },
            1 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.String);
                Value::String(ans.field0.wire2api())
            },
            2 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.ErrorValue);
                Value::ErrorValue(ans.field0.wire2api(), ans.field1.wire2api())
            },
            3 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.Error);
                Value::Error(ans.field0.wire2api())
            },
            4 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.ConnectionType);
                Value::ConnectionType(ans.field0.wire2api(), ans.field1.wire2api())
            },
            _ => unreachable!(),
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Value {
    tag: i32,
    kind: *mut ValueKind,
}

#[repr(C)]
pub union ValueKind {
    Int: *mut wire_Value_Int,
    String: *mut wire_Value_String,
    ErrorValue: *mut wire_Value_ErrorValue,
    Error: *mut wire_Value_Error,
    ConnectionType: *mut wire_Value_ConnectionType,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Value_Int {
    field0: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Value_String {
    field0: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Value_ErrorValue {
    field0: i32,
    field1: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Value_Error {
    field0: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Value_ConnectionType {
    field0: i32,
    field1: *mut wire_uint_8_list,
}
// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

impl Default for wire_Value {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_Value {
    fn new_with_null_ptr() -> Self {
        Self {
            tag: -1,
            kind: core::ptr::null_mut(),
        }
    }
}

#[no_mangle]
pub extern "C" fn inflate_Value_Int() -> *mut ValueKind {
    support::new_leak_box_ptr(ValueKind {
        Int: support::new_leak_box_ptr(wire_Value_Int {
            field0: Default::default(),
        }),
    })
}

#[no_mangle]
pub extern "C" fn inflate_Value_String() -> *mut ValueKind {
    support::new_leak_box_ptr(ValueKind {
        String: support::new_leak_box_ptr(wire_Value_String {
            field0: core::ptr::null_mut(),
        }),
    })
}

#[no_mangle]
pub extern "C" fn inflate_Value_ErrorValue() -> *mut ValueKind {
    support::new_leak_box_ptr(ValueKind {
        ErrorValue: support::new_leak_box_ptr(wire_Value_ErrorValue {
            field0: Default::default(),
            field1: core::ptr::null_mut(),
        }),
    })
}

#[no_mangle]
pub extern "C" fn inflate_Value_Error() -> *mut ValueKind {
    support::new_leak_box_ptr(ValueKind {
        Error: support::new_leak_box_ptr(wire_Value_Error {
            field0: Default::default(),
        }),
    })
}

#[no_mangle]
pub extern "C" fn inflate_Value_ConnectionType() -> *mut ValueKind {
    support::new_leak_box_ptr(ValueKind {
        ConnectionType: support::new_leak_box_ptr(wire_Value_ConnectionType {
            field0: Default::default(),
            field1: core::ptr::null_mut(),
        }),
    })
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
