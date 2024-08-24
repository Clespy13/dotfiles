{ config, lib, unstable, pkgs, ... }:
{
  options = {
    hyprland.enable =
      lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    imports = [
      (import ./environment/common-variables.nix)
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

    home.pointerCursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 32;
      gtk.enable = true;
    };

    home.packages = with pkgs; [
      wayland
      unstable.waybar
      wayidle
      wl-clipboard
      rofi-wayland
      rofimoji
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xwaylandvideobridge
      qt6.qtwayland
      electron
      xwayland

      hyprpicker
      hyprpaper
      unstable.hypridle
      unstable.hyprlock
      unstable.hyprcursor

      wayland-scanner
      wayland-utils
      wlroots
      wlrctl
      wlr-protocols
      wlr-randr
      xdg-desktop-portal-wlr
      xdg-utils
      egl-wayland
      glfw-wayland
      wine-wayland
      way-displays
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      package = unstable.hyprland;
      settings = import ./config.nix;
    };
  };
}
