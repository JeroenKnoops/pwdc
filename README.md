## pwdc

This tool will take the current directory and puts it on the clipboard.

### Limitations

- Nix devShell only works on mac
- No nix package include

## Usage

### Use in home-manager

```
  pwdc = import (builtins.fetchGit {
      url = "https://github.com/JeroenKnoops/pwdc";
      rev = "0bc5371bdd760b1056b227487842be4fdaa07e7c";
  }) {};
```

...

```
    home.packages = [
      pwdc
      pkgs.fzf
      ....
```

### Use in flake

```
{
  description = "Example rust project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pwdc-repo.url = "github:jeroenknoops/pwdc";
  };

  outputs = { self, nixpkgs, flake-utils, pwdc-repo }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pwdc = import pwdc-repo { inherit pkgs; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs =
            let
              inherit (pkgs.darwin.apple_sdk.frameworks) SystemConfiguration;
            in [
                pkgs.cargo
                pkgs.libiconv
                pkgs.cmake
                pwdc
            ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
              SystemConfiguration
            ];
        };
      }
    );
}

```
