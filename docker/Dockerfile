FROM ghcr.io/cirruslabs/flutter:3.22.2

ENV ANDROID_NDK_VERSION 23.1.7779620
ENV PATH="/root/.cargo/bin:$PATH"


RUN yes | sdkmanager "ndk;$ANDROID_NDK_VERSION"
RUN yes | sdkmanager "cmake;3.18.1"
RUN yes | sdkmanager "build-tools;30.0.3"
RUN yes | sdkmanager "platforms;android-33"
RUN yes | sdkmanager "platforms;android-32"
RUN yes | sdkmanager "platforms;android-31"

RUN echo "INPUT(-lunwind)" > /opt/android-sdk-linux/ndk/$ANDROID_NDK_VERSION/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/12.0.8/lib/linux/aarch64/libgcc.a
RUN echo "INPUT(-lunwind)" > /opt/android-sdk-linux/ndk/$ANDROID_NDK_VERSION/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/12.0.8/lib/linux/arm/libgcc.a
RUN echo "INPUT(-lunwind)" > /opt/android-sdk-linux/ndk/$ANDROID_NDK_VERSION/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/12.0.8/lib/linux/i386/libgcc.a
RUN echo "INPUT(-lunwind)" > /opt/android-sdk-linux/ndk/$ANDROID_NDK_VERSION/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/12.0.8/lib/linux/x86_64/libgcc.a

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
    && rustup install 1.75.0 \
    && rustup default 1.75.0 \
    && echo "export ANDROID_NDK_HOME=/opt/android-sdk-linux/ndk/$ANDROID_NDK_VERSION" >> $HOME/.bashrc \
    && cargo install cargo-ndk

RUN cargo install flutter_rust_bridge_codegen \
    && cargo install cargo-expand

WORKDIR /root/wormhole