FROM rust:slim-buster

RUN dpkg --add-architecture arm64
RUN dpkg --add-architecture armhf
RUN apt-get update

RUN apt-get install -qy dpkg-dev
RUN apt-get install -qy g++-aarch64-linux-gnu libc6-dev-arm64-cross binutils-aarch64-linux-gnu
RUN apt-get install -qy g++-arm-linux-gnueabihf libc6-dev-armhf-cross binutils-arm-linux-gnueabihf

RUN rustup target add aarch64-unknown-linux-gnu
RUN rustup target add armv7-unknown-linux-gnueabihf

RUN mkdir -p ~/.cargo/
RUN touch ~/.cargo/config
RUN echo "[target.aarch64-unknown-linux-gnu]\nobjcopy = { path = \"aarch64-linux-gnu-objcopy\" }\nstrip = { path = \"aarch64-linux-gnu-strip\" }\n" > ~/.cargo/config
RUN echo "[target.armv7-unknown-linux-gnueabihf]\nobjcopy = { path = \"arm-linux-gnueabihf-objcopy\" }\nstrip = { path = \"arm-linux-gnueabihf-strip\" }" > ~/.cargo/config

RUN cargo install cargo-deb --version 1.38.0 --locked

ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc \
    CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc \
    CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++

ENV CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_LINKER=arm-linux-gnueabihf-gcc \
    CC_arm_unknown_linux_gnueabihf=arm-linux-gnueabihf-gcc \
    CXX_arm_unknown_linux_gnueabihf=arm-linux-gnueabihf-g++

COPY entry.sh /entry.sh
ENTRYPOINT ["/entry.sh"]