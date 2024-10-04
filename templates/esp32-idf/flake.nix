{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    esp32 = {
      url = "github:knarkzel/esp32";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , esp32
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
      idf-rust = esp32.packages.x86_64-linux.esp32;
      fhs = pkgs.buildFHSUserEnv {
        name = "fhs-shell";
        targetPkgs = pkgs: with pkgs; [
          gcc

          pkg-config
          gnumake
          cmake
          ninja

          git
          wget

          idf-rust
          cargo-generate
          cargo-espflash

          espflash
          python3
          python3Packages.pip
          python3Packages.virtualenv
          ldproxy
        ];
        profile = ''
          					export LIBCLANG_PATH="${idf-rust}/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-17.0.1_20240419/esp-clang/lib"
          					export PATH="${idf-rust}/.rustup/toolchains/esp/bin:$PATH"
          					export PATH="${idf-rust}/.rustup/toolchains/esp/xtensa-esp-elf/esp-13.2.0_20230928/xtensa-esp-elf/bin:$PATH"
          					export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
        '';
      };
    in
    {
      devShells.${pkgs.system} = {
        default = fhs.env;
        flash = pkgs.mkShell {
          packages = [
            pkgs.espflash
            pkgs.cargo-generate
          ];
        };
      };
    };
}
