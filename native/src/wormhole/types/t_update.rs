use crate::api::{Events, Value};

pub struct TUpdate {
    pub event: Events,
    pub value: Value,
}

impl TUpdate {
    pub fn new(event: Events, value: Value) -> TUpdate {
        TUpdate { event, value }
    }
}
