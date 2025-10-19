{ config, lib, pkgs, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) system;
  pwdcPkg = (import ../flake.nix).outputs { inherit system; nixpkgs = pkgs; }.packages.${system}.default;
in {
  options.programs.pwdc.enable = lib.mkEnableOption "Enable pwdc";

  config = lib.mkIf config.programs.pwdc.enable {
    home.packages = [ pwdcPkg ];
  };
}

