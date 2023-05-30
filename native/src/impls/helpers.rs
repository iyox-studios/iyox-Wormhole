use magic_wormhole::rendezvous::DEFAULT_RENDEZVOUS_SERVER;
use magic_wormhole::transfer::{AppVersion, APPID};
use magic_wormhole::{transit, AppConfig};
use std::borrow::Cow;

/// generate default relay hints
pub fn gen_relay_hints() -> Vec<transit::RelayHint> {
    let mut relay_hints: Vec<transit::RelayHint> = vec![];
    if relay_hints.is_empty() {
        relay_hints.push(
            transit::RelayHint::from_urls(None, [transit::DEFAULT_RELAY_SERVER.parse().unwrap()])
                .unwrap(),
        )
    }
    relay_hints
}

/// generate default app config
pub fn gen_app_config() -> AppConfig<AppVersion> {
    AppConfig {
        id: APPID,
        rendezvous_url: Cow::from(DEFAULT_RENDEZVOUS_SERVER),
        app_version: AppVersion {},
    }
}
