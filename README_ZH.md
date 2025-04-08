<div align="center">

<div align="center">
    <img width="200" height="200" style="display: block; border-radius: 9999px;" src="https://raw.githubusercontent.com/iyox-Studios/iyox-Wormhole/main/assets/icon/icon.png">
</div>

---
# iyox Wormhole

**iyox Wormhole** 是一款采用 [Material You](https://m3.material.io/) 风格设计的文件传输应用。  
本项目是 [这个项目](https://gitlab.com/lukas-heiligenbrunner/wormhole) 的一个分支。

[English](README.md) | 简体中文

[<img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" alt="Get it on Google Play Store" height="75">](https://play.google.com/store/apps/details?id=com.iyox.wormhole)[<img src="https://gitlab.com/IzzyOnDroid/repo/-/raw/master/assets/IzzyOnDroid.png" alt="Get it on IzzyOnDroid" height="75">](https://apt.izzysoft.de/packages/com.iyox.wormhole)

</div>

## 截图

[<img width=200 alt="截图 1" src="https://raw.githubusercontent.com/iyox-Studios/iyox-Wormhole/main/fastlane/metadata/android/en-US/images/phoneScreenshots/1_en-US.png?raw=true">]()
[<img width=200 alt="截图 2" src="https://raw.githubusercontent.com/iyox-Studios/iyox-Wormhole/main/fastlane/metadata/android/en-US/images/phoneScreenshots/2_en-US.png?raw=true">]()
[<img width=200 alt="截图 3" src="https://raw.githubusercontent.com/iyox-Studios/iyox-Wormhole/main/fastlane/metadata/android/en-US/images/phoneScreenshots/3_en-US.png?raw=true">]()
[<img width=200 alt="截图 4" src="https://raw.githubusercontent.com/iyox-Studios/iyox-Wormhole/main/fastlane/metadata/android/en-US/images/phoneScreenshots/5_en-US.png?raw=true">]()

## 开发

（开发部分尚未填写）

## 功能特色

- **安全的文件共享**：使用 magic-wormhole 协议实现端到端加密传输。
- **Material You 风格**：采用现代 Material You 设计，提升用户体验。
- **二维码与口令共享**：通过二维码或口令简化分享流程。

## 所用库

### Flutter 相关

- [flutter_rust_bridge](https://github.com/fzyzcjy/flutter_rust_bridge)（MIT）- Flutter 与 Rust 的 ffi 桥接代码生成器  
- [ffi](https://pub.dev/packages/ffi)（BSD-3-Clause）- 从 Dart 调用本地 .so 库  
- [file_picker](https://pub.dev/packages/file_picker)（MIT）- 跨平台原生文件选择器  
- [path_provider](https://pub.dev/packages/path_provider)（BSD-3-Clause）- 获取平台常用路径  
- [flutter_zxing](https://pub.dev/packages/flutter_zxing)（MIT）- 支持 QR/Aztec 的二维码扫描器  
- [qr_flutter](https://pub.dev/packages/qr_flutter)（BSD-3-Clause）- 二维码生成器  
- [shared_preferences](https://pub.dev/packages/shared_preferences)（BSD-3-Clause）- 跨平台的键值对存储  
- [share_handler](https://pub.dev/packages/share_handler)（MIT）- 接收平台的分享意图  
- [vibration](https://pub.dev/packages/vibration)（BSD-2-Clause）- 控制震动反馈  
- [dynamic_color](https://pub.dev/packages/dynamic_color)（Apache-2.0）- 生成 Material 配色方案  
- [animations](https://pub.dev/packages/animations)（BSD-3-Clause）- 预置动画组件  
- [gap](https://pub.dev/packages/gap)（MIT）- 用于 Flex 布局中添加间距  
- [flutter_displaymode](https://pub.dev/packages/flutter_displaymode)（MIT）- 设置 Android 显示模式  

### Rust 相关

- [anyhow](https://crates.io/crates/anyhow)（MIT）- 错误处理库  
- [magic-wormhole](https://crates.io/crates/magic-wormhole)（EUPL-1.2）- magic-wormhole 客户端实现  
- [futures](https://crates.io/crates/futures)（MIT）- 异步编程支持  
- [async-std](https://crates.io/crates/async-std)（MIT）- 异步标准库  
- [url](https://crates.io/crates/url)（MIT）- URL 生成工具  
- [yaml-rust](https://crates.io/crates/yaml-rust)（MIT）- YAML 解析器  

## 许可证

**iyox Wormhole** 遵循 [GPL 协议](LICENSE) 开源发布。