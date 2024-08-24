{ config, lib, pkgs, ... }:
{
  options.notifications = {
    mako.enable =
      lib.mkEnableOption "Enable mako";
  };

  config = lib.mkIf config.notifications.mako.enable {
    home.file = {
      ".config/mako" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
