FROM ghcr.io/cirruslabs/flutter:latest

ENV ANDROID_NDK_VERSION 24.0.8215888
ENV PATH="/root/.cargo/bin:$PATH"


RUN yes | sdkmanager "ndk;$ANDROID_NDK_VERSION"

RUN echo "INPUT(-lunwind)" > /opt/android-sdk-linux/ndk/$ANDROID_NDK_VERSION/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/14.0.1/lib/linux/aarch64/libgcc.a
RUN echo "INPUT(-lunwind)" > /opt/android-sdk-linux/ndk/$ANDROID_NDK_VERSION/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/14.0.1/lib/linux/arm/libgcc.a
RUN echo "INPUT(-lunwind)" > /opt/android-sdk-linux/ndk/$ANDROID_NDK_VERSION/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/14.0.1/lib/linux/i386/libgcc.a
RUN echo "INPUT(-lunwind)" > /opt/android-sdk-linux/ndk/$ANDROID_NDK_VERSION/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/14.0.1/lib/linux/x86_64/libgcc.a

RUN apt update && apt install -y \
    build-essential \
    clang \
    llvm \
    curl \
    git \
    libssl-dev \
    libgtk-3-dev \
    ninja-build \
    cmake

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && . "$HOME/.cargo/env" \
    && rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android \
    && echo "export ANDROID_NDK_HOME=/opt/android-sdk-linux/ndk/$ANDROID_NDK_VERSION" >> $HOME/.bashrc \
    && cargo install cargo-ndk

RUN cargo install flutter_rust_bridge_codegen \
    && cargo install cargo-expand

WORKDIR /root/wormhole