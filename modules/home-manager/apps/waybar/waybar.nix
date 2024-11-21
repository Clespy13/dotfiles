{ config, lib, pkgs, ... }:
{
  options.myHome = {
    waybar.enable =
      lib.mkEnableOption "Enable waybar";
  };

  config = lib.mkIf config.myHome.waybar.enable {
    home.file = {
      ".config/waybar" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
