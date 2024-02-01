use crate::api::ErrorType;

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
