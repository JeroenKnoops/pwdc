{
  description = "Rust project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        buildInputs = [ 
          pkgs.cargo 
          pkgs.libiconv
          pkgs.darwin.apple_sdk.frameworks.AppKit
        ];
        manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = buildInputs; 
        };

  packages.default = pkgs.rustPlatform.buildRustPackage rec {
    buildInputs = [ 
      pkgs.darwin.apple_sdk.frameworks.AppKit
    ];
    pname = manifest.name;
    version = manifest.version;
    cargoLock.lockFile = ./Cargo.lock;
    src = pkgs.lib.cleanSource ./.;
    meta = with pkgs.lib; {
      description = "This tool will take the current directory and puts it on the clipboard.";
      homepage = "https://github.com/jeroenkoops/pwdc";
      license = licenses.mit;
      maintainers = [ jeroenknoops ];
    };
  };
  
} );
}
