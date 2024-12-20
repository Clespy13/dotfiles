{ config, lib, unstable, pkgs, ... }:
{
  options.myHome = {
    hyprland.enable =
      lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf config.myHome.hyprland.enable {
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
      waybar
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
      hypridle
      hyprlock
      hyprcursor

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

    home = {
      sessionVariables = {
        BROWSER = "brave";
        TERMINAL = "alacritty";

        XDG_CONFIG_HOME = "\${HOME}/.config";
        XDG_CACHE_HOME = "\${HOME}/.cache";
        XDG_BIN_HOME = "\${HOME}/.local/bin";
        XDG_DATA_HOME = "\${HOME}/.local/share";
      };
      sessionPath = [
        "$HOME/.local/bin"
      ];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      package = pkgs.hyprland;
      settings = import ./config.nix;
    };
  };
}
