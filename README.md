# cargo-deb-arm

Very simple Dockerfile + action containing cargo deb. Based on [cargo-deb-armv7-debian](https://github.com/ebbflow-io/cargo-deb-armv7-debian)
and [rust-crosscompiler-arm](https://github.com/dlecan/rust-crosscompiler-arm).

Currently only supports:

- aarch64-unknown-linux-gnu
- armv7-unknown-linux-gnueabihf

Open to adding more as required.

Originally written for use in [bottom](https://github.com/ClementTsang/bottom).
