use crate::api::ServerConfig;
use magic_wormhole::transfer::{AppVersion, APPID};
use magic_wormhole::{transit, AppConfig};
use std::borrow::Cow;

/// generate default relay hints
pub fn gen_relay_hints(s_conf: &ServerConfig) -> anyhow::Result<Vec<transit::RelayHint>> {
    Ok(vec![transit::RelayHint::from_urls(
        None,
        [s_conf.transit_url.parse()?],
    )?])
}

/// generate default app config
pub fn gen_app_config(s_conf: &ServerConfig) -> AppConfig<AppVersion> {
    AppConfig {
        id: APPID,
        rendezvous_url: Cow::from(s_conf.rendezvous_url.clone()),
        app_version: AppVersion {},
    }
}
