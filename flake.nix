{
  description = "linux dev example";

  inputs = {
    # nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
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
            zlib
            (rust-bin.stable."1.74.1".default.override {
                extensions = [ "rust-src" ];
            })
            gnumake
            rust-bindgen
            flex
            bison
            ncurses
            bc
            llvmPackages_16.bintools-unwrapped
            llvmPackages_16.clang-unwrapped
            elfutils
            glibc
          ];

          shellHook = ''
          '';
        };
      }
    );
}
