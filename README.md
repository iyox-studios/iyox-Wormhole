<div align="center">

<div align="center">
    <img width="200" height="200" style="display: block; border-radius: 9999px;" src="https://raw.githubusercontent.com/iyox-Studios/iyox-Wormhole/main/assets/icon/icon.png">
</div>

---
# iyox Wormhole

iyox Wormhole is a file-sharing application presented in [Material You](https://m3.material.io/) style.
It is a fork of [this](https://gitlab.com/lukas-heiligenbrunner/wormhole) project.

English | [简体中文](/README_ZH.md)

[<img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" alt="Get it on Google Play Store" height="75">](https://play.google.com/store/apps/details?id=com.iyox.wormhole)[<img src="https://gitlab.com/IzzyOnDroid/repo/-/raw/master/assets/IzzyOnDroid.png" alt="Get it on IzzyOnDroid" height="75">](https://apt.izzysoft.de/packages/com.iyox.wormhole)

</div>

## Screenshots

[<img width=200 alt="Screenshot 1" src="https://raw.githubusercontent.com/iyox-Studios/iyox-Wormhole/main/fastlane/metadata/android/en-US/images/phoneScreenshots/1_en-US.png?raw=true">]()
[<img width=200 alt="Screenshot 2" src="https://raw.githubusercontent.com/iyox-Studios/iyox-Wormhole/main/fastlane/metadata/android/en-US/images/phoneScreenshots/2_en-US.png?raw=true">]()
[<img width=200 alt="Screenshot 3" src="https://raw.githubusercontent.com/iyox-Studios/iyox-Wormhole/main/fastlane/metadata/android/en-US/images/phoneScreenshots/3_en-US.png?raw=true">]()
[<img width=200 alt="Screenshot 4" src="https://raw.githubusercontent.com/iyox-Studios/iyox-Wormhole/main/fastlane/metadata/android/en-US/images/phoneScreenshots/5_en-US.png?raw=true">]()

## Development


## Features

- Secure File Sharing: Utilizes the magic-wormhole protocol for end-to-end encrypted file transfers.
- Material You Design: Enhances user experience with modern Material You design principles.
- QR Code and Passphrase Sharing: Simplifies sharing through QR codes or passphrases.

## Used Libraries

### Flutter

* [flutter_rust_bridge](https://github.com/fzyzcjy/flutter_rust_bridge)(MIT) - Flutter <-> Rust ffi code generation
* [ffi](https://pub.dev/packages/ffi)(BSD-3-Clause) - call native .so lib code from dart
* [file_picker](https://pub.dev/packages/file_picker)(MIT) - OS Native Filepicker Impl.
* [path_provider](https://pub.dev/packages/path_provider)(BSD-3-Clause) - Get Platforms common paths
* [flutter_zxing](https://pub.dev/packages/flutter_zxing)(MIT) - QR/Aztec code scanner
* [qr_flutter](https://pub.dev/packages/qr_flutter)(BSD-3-Clause) - QR code generator
* [shared_preferences](https://pub.dev/packages/shared_preferences)(BSD-3-Clause) - Platform wrapper for key-value pairs
* [share_handler](https://pub.dev/packages/share_handler)(MIT) - receive of platform share intents
* [vibration](https://pub.dev/packages/vibration)(BSD-2-Clause) - control haptic feedbacks
* [dynamic_color](https://pub.dev/packages/dynamic_color)(Apache-2.0) - generate Material color schemes
* [animations](https://pub.dev/packages/animations)(BSD-3-Clause ) - pre-built animations
* [gap](https://pub.dev/packages/gap)(MIT) - add gaps in flex widgets
* [flutter_displaymode](https://pub.dev/packages/flutter_displaymode)(MIT) - set display mode on android

### Rust

* [anyhow](https://crates.io/crates/anyhow)(MIT) - Error handling
* [magic-wormhole](https://crates.io/crates/magic-wormhole)(EUPL-1.2) - magic-wormhole client
* [futures](https://crates.io/crates/futures)(MIT) - async/await async programming
* [async-std](https://crates.io/crates/async-std)(MIT) - async std-lib
* [url](https://crates.io/crates/url)(MIT) - url generation lib
* [yaml-rust](https://crates.io/crates/yaml-rust)(MIT) - yaml parser


## License

iyox Wormhole is licensed under the [GPL License](LICENSE).
