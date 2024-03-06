{
  description = "linux dev example";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [
            openssl
            pkg-config
            elfutils
            zlib
            (rust-bin.stable.latest.default.override {
                extensions = [ "rust-src" ];
            })
            lld_17
            gnumake
            rust-bindgen
            flex
            bison
            ncurses
            bc
            llvmPackages_17.bintools-unwrapped
            elfio
          ];

          shellHook = ''
          '';
        };
      }
    );
}
