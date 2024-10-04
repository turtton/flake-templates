{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          formatter = pkgs.nixpkgs-fmt;
          devShells.default = pkgs.mkShell {
            packages = [ pkgs.bashInteractive ];
          };
        }) // {
      templates = {
        corepack = {
          path = ./templates/corepack;
          description = "nix flake new -t github:turtton/flake-templates#corepack";
        };
        esp32-idf = {
          path = ./templates/esp32-idf;
          description = "nix flake new -t github:turtton/flake-templates#esp32-idf";
        };
      };
    };
}
