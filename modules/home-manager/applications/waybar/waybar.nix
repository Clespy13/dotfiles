{ config, lib, pkgs, ... }:
{
  options = {
    waybar.enable =
      lib.mkEnableOption "Enable waybar";
  };

  config = lib.mkIf config.waybar.enable {
    home.file = {
      ".config/waybar" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
