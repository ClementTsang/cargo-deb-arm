# cargo-deb-arm

A very simple Dockerfile + action for ARM cross-compilation with cargo deb. Based on [cargo-deb-armv7-debian](https://github.com/ebbflow-io/cargo-deb-armv7-debian)
and [rust-crosscompiler-arm](https://github.com/dlecan/rust-crosscompiler-arm).

Currently only supports:

- aarch64-unknown-linux-gnu
- armv7-unknown-linux-gnueabihf

Open to adding more as required, feel free to submit PRs + tests.

Originally written for use in [bottom](https://github.com/ClementTsang/bottom).

## Action

To use the included action in a workflow:

### Inputs

#### `args`

The arguments you wish to pass to `cargo deb`.

#### `working-directory`

The working directory, if the default repo directory isn't where you want to run `cargo deb` on.

### Outputs

No outputs, the build artifacts should be in the directory you gave.

### Example Usage

```yaml
- name: Run cargo deb
  uses: ClementTsang/cargo-deb-arm@v0.0.2-alpha
  with:
    args: --target aarch64-unknown-linux-gnu
    working-directory: test/hello_world
```

See the [test workflow](./.github/workflows/test.yml) for a more complete example of usage.

## Dockerfile

You can also directly use the Dockerfile (which is published as a ghcr image). For example:

```bash
docker pull ghcr.io/clementtsang/cargo-deb-arm:latest

docker run -t --rm --mount type=bind,source="$(pwd)",target=/volume \
  ghcr.io/clementtsang/cargo-deb-arm \
  "--target ${{ matrix.triple.arch }}" \
  "/volume/test/hello_world"
```

More specialized Dockerfiles are also included and published (see [`./docker`](./docker/)). For example:

```bash
docker pull ghcr.io/clementtsang/cargo-deb-aarch64-unknown-linux-gnu:latest

docker run -t --rm --mount type=bind,source="$(pwd)",target=/volume \
  ghcr.io/clementtsang/cargo-deb-aarch64-unknown-linux-gnu \
  "--target ${{ matrix.triple.arch }}" \
  "/volume/test/hello_world"
```

Note that the `latest` tag generally points to the latest *stable* Rust version. When a new stable Rust version comes out, this is usually automatically updated as the corresponding Docker container updates.

## Known Problems

It seems like the automatic dependency detection includes the cross-compilation libraries, which may not be desirable. I'm not sure how to resolve this at the moment, but a (kinda bad) workaround is manually setting platform-specific `depends` overrides in your main project's `Cargo.toml`, and calling them as needed. For example:

```toml
# Cargo.toml

[package.metadata.deb]
section = "utility"

[package.metadata.deb.variants.arm64]
depends = "libc6:arm64 (>= 2.28)"
```

```yaml
- name: Run cargo deb
  uses: ClementTsang/cargo-deb-arm@v0.0.2-alpha
  with:
    args: --target aarch64-unknown-linux-gnu --variant arm64
    working-directory: test/hello_world
```

See [cargo-deb's documentation](https://github.com/kornelski/cargo-deb#packagemetadatadebvariantsname) for more information.
