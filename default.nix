{ pkgs ? import <nixpkgs> { } }:

let manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
in
  pkgs.rustPlatform.buildRustPackage rec {
    buildInputs = [ 
      pkgs.darwin.apple_sdk.frameworks.AppKit
    ];
    pname = manifest.name;
    version = manifest.version;
    cargoLock.lockFile = ./Cargo.lock;
    src = pkgs.lib.cleanSource ./.;
  }
