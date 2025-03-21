use std::rc::Rc;

use async_std::sync::{Arc, Condvar, Mutex};
use futures::future::BoxFuture;
use futures::FutureExt;
use magic_wormhole::transit::{ConnectionType, TransitInfo};
use crate::api::{Events, TUpdate, Value};
use crate::wormhole::types::value;

use crate::frb_generated::StreamSink;


/// generate dummy implementation for cancel handler
pub fn gen_handler_dummy<'a>() -> BoxFuture<'a, ()> {
    let notifier = Arc::new((Mutex::new(false), Condvar::new()));
    return async move {
        let (lock, cvar) = &*notifier;
        let mut started = lock.lock().await;
        while !*started {
            started = cvar.wait(started).await;
        }
    }
    .boxed();
}

/// generate new transithandler which callbacks connectiontype through streamsink
pub fn gen_transit_handler(
    actions: Rc<StreamSink<TUpdate>>,
) -> Box<dyn Fn(TransitInfo)> {
    let fnn = move |info: TransitInfo| {
        match info.conn_type {
            ConnectionType::Direct => {
                actions.add(TUpdate::new(
                    Events::ConnectionType,
                    Value::ConnectionType(value::ConnectionType::Direct, info.peer_addr.to_string()),
                ));
            }
            ConnectionType::Relay { name: Some(n) } => {
                actions.add(TUpdate::new(
                    Events::ConnectionType,
                    Value::ConnectionType(value::ConnectionType::Relay, n),
                ));
            }
            ConnectionType::Relay { name: None } => {
                actions.add(TUpdate::new(
                    Events::ConnectionType,
                    Value::ConnectionType(value::ConnectionType::Relay, info.peer_addr.to_string()),
                ));
            }
            _ => {}
        };
    };
    Box::new(fnn)
}

/// generate new progress handler to callback through streamsink
pub fn gen_progress_handler(action: Rc<StreamSink<TUpdate>>) -> Box<dyn Fn(u64, u64)> {
    let handler = move |received: u64, total: u64| {
        if received == 0 {
            action.add(TUpdate::new(Events::Total, Value::Int(total as i32)));
            action.add(TUpdate::new(Events::StartTransfer, Value::Int(-1)));
        }
        action.add(TUpdate::new(Events::Sent, Value::Int(received as i32)));
    };
    Box::new(handler)
}
