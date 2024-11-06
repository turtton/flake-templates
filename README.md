# flake-templates

Usage:

```sh
nix flake init -t github:turtton/flake-templates#{name}
```

All templates based on [nix-direnv](https://github.com/nix-community/nix-direnv) flake template

## Template list

- `corepack`
  Please craete `package.json` and specify `packageManager`(use: `corepack use pnpm`) before use this template.

- `esp32-idf`
  After initialize flakes. Use `cargo-generate` to ini rust project like `cargo generate --init esp-rs/esp-idf-template cargo`(See [esp-idf-template](https://github.com/esp-rs/esp-idf-template))
  > [!important]
  > `cargo run` does not work in build environment(`nix develop`). Use `sudo espflash flash --monitor target/xtensa-esp32-espidf/release/<appname>` outside of build environment(Direnv provides path to espflash command)

- `rust`
