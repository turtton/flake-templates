{
  description = "Falke for Rust using direnv";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    with pkgs; {
      formatter = nixpkgs-fmt;
      devShells.default = mkShell {
        nativeBuildInputs = [ pkg-config ];
        # buildInputs = [ openssl ];
        # packages = [
        #   sqlx-cli
        # ];
      };
    });
}
