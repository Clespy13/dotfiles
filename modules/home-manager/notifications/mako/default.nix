{ config, lib, pkgs, ... }:
{
  options.notifications.mako = {
    enable = lib.mkEnableOption "Enable mako";
  };

  config = lib.mkIf config.notifications.mako.enable {
    home.packages = with pkgs; [
      mako
    ];

    home.file = {
      ".config/mako/config" = {
        source = ./config;
      };
    };
  };
}
