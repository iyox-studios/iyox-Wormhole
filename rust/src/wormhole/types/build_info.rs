use macros::{build_time, version_str};

pub struct BuildInfo {
    pub build_time: u64,
    pub dev_build: bool,
    pub version: String,
}

impl BuildInfo {
    pub fn new() -> BuildInfo {
        BuildInfo {
            build_time: build_time!(),
            dev_build: cfg!(debug_assertions),
            version: version_str!().to_string(),
        }
    }
}
