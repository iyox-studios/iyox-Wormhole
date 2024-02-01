use crate::api::{ConnectionType, Events, TUpdate, Value};
use async_std::sync::{Arc, Condvar, Mutex};
use flutter_rust_bridge::StreamSink;
use futures::future::BoxFuture;
use futures::FutureExt;
use magic_wormhole::transit::TransitInfo;
use std::net::SocketAddr;
use std::rc::Rc;

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
) -> Box<dyn Fn(TransitInfo, SocketAddr)> {
    let fnn = move |info: TransitInfo, peer_addr: SocketAddr| {
        match info {
            TransitInfo::Direct => {
                actions.add(TUpdate::new(
                    Events::ConnectionType,
                    Value::ConnectionType(ConnectionType::Direct, peer_addr.to_string()),
                ));
            }
            TransitInfo::Relay { name: Some(n) } => {
                actions.add(TUpdate::new(
                    Events::ConnectionType,
                    Value::ConnectionType(ConnectionType::Relay, n),
                ));
            }
            TransitInfo::Relay { name: None } => {
                actions.add(TUpdate::new(
                    Events::ConnectionType,
                    Value::ConnectionType(ConnectionType::Relay, peer_addr.to_string()),
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
