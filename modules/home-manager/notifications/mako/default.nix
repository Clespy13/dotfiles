{ config, lib, pkgs, ... }:
{
  options.myHome.mako = {
    enable = lib.mkEnableOption "Enable mako";
  };

  config = lib.mkIf config.myHome.mako.enable {
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
