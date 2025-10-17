{
  description = "Rust project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk";
  };

  outputs = { self, nixpkgs, naersk, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
        naerskLib = pkgs.callPackage naersk { };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [ 
            libxcb
            libxcb-render-util
            libxcb-image
            libxcb-keysyms
            cargo 
            rustc 
            rustfmt
            clippy
            rust-analyzer
            libiconv
            xclip
          ];
        };
        
        packages.default = naerskLib.buildPackage {
          pname = manifest.name;
          version = manifest.version;
          src = pkgs.lib.cleanSource ./.;
          buildInputs = with pkgs; [
            libxcb
            libxcb-render-util
            libxcb-image
            libxcb-keysyms
          ];
          nativeBuildInputs = with pkgs; [
            pkg-config
          ];
          meta = with pkgs.lib; {
            description = "This tool will take the current directory and puts it on the clipboard.";
            homepage = "https://github.com/jeroenknoops/pwdc";
            license = licenses.mit;
            maintainers = with maintainers; [ jeroenknoops ];
          };
        };
      }
    );
}
