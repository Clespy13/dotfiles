{ config, lib, pkgs, inputs, ... }:
{
  options.myHome.firefox.enable = lib.mkEnableOption "Enable firefox";

  config = lib.mkIf config.myHome.firefox.enable {
    programs.firefox.enable = true;
  };
}
