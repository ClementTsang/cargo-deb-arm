# cargo-deb-arm

Very simple Dockerfile + action containing cargo deb. Based on [cargo-deb-armv7-debian](https://github.com/ebbflow-io/cargo-deb-armv7-debian)
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
  uses: ClementTsang/cargo-deb-arm@v0.0.1-alpha
  with:
    args: --target aarch64-unknown-linux-gnu
    working-directory: test/hello_world
```

See the [test workflow](./.github/workflows/test.yml) for a more complete example of usage.

## Dockerfile

You can also directly use the Dockerfile (which is also published as a package). For example:

```bash

```

More specialized Dockerfiles are also included and published (see [`./docker`](./docker/)). For example:

```bash

```
