{ config, lib, pkgs, ... }:
{
  imports = [
    (import ../../modules/environment/common-variables.nix)
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-dark-gtk;
    };
  };

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  home.file = {
    ".config/hypr" = {
      source = ./config;
      recursive = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    settings = import ./config.nix;
  };
}
