{ config, lib, pkgs, ... }:
{
  options = {
    waybar.enable =
      lib.mkEnableOption "Enable waybar";
  };

  config = lib.mkIf config.options.enable {
    home.file = {
      ".config/waybar" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
