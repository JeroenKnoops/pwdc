{ config, lib, pkgs, pwdcPackage ? null, ... }:

{
  options.programs.pwdc.enable = lib.mkEnableOption "Enable the pwdc CLI tool";

  config = lib.mkIf config.programs.pwdc.enable {
    assert pwdcPackage != null;
    home.packages = [ pwdcPackage ];
  };
}

