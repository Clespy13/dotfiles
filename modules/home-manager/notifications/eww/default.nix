{config, lib, pkgs, unstable, ...}:
{
  options.myHome.eww.enable = lib.mkEnableOption "enable eww";

  config = lib.mkIf config.myHome.eww.enable {
    home.packages = with pkgs; [
      eww

      # glib
      # gobject-introspection

      # (unstable.python312.withPackages (ps: [
      #   ps.dbus-python
      #   ps.pygobject3
      #   ps.jedi-language-server
      # ]))
    ];

    home.file = {
      ".config/eww" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
