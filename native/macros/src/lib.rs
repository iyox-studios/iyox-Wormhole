use std::time::{SystemTime, UNIX_EPOCH};
extern crate proc_macro;
use proc_macro::TokenStream;
use std::fs::read_to_string;

extern crate yaml_rust;
use yaml_rust::{YamlLoader};

#[proc_macro]
pub fn version_str(_item: TokenStream) -> TokenStream {
    let pubspec= read_to_string("/home/ewuuwe/Coding/Flutter/iyox-Wormhole/pubspec.yaml").expect("failed to read yaml file");
    let yml = YamlLoader::load_from_str(pubspec.as_str()).expect("Failed to parse yaml");
    let doc = &yml[0];
    let version = doc["version"].as_str().expect("couldnt get version from yaml object");
    format!("\"{}\"", version).parse().expect("couldn't parse string to tokenstream")
}



#[proc_macro]
pub fn build_time(_item: TokenStream) -> TokenStream {
    let start = SystemTime::now();
    let since_the_epoch = start
        .duration_since(UNIX_EPOCH)
        .expect("Time went backwards");

    since_the_epoch.as_millis().to_string().parse().unwrap()
}

