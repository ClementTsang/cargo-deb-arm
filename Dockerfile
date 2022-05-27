FROM rust:slim-buster

RUN dpkg --add-architecture arm64
RUN apt-get update
RUN apt-get install -qy g++-aarch64-linux-gnu libc6-dev-arm64-cross

RUN rustup target add aarch64-unknown-linux-gnu
RUN rustup toolchain install stable-aarch64-unknown-linux-gnu

RUN cargo install cargo-deb --version 1.38.0 --locked

COPY entry.sh /entry.sh

ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc \
    CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc \
    CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++

ENTRYPOINT ["/entry.sh"]
