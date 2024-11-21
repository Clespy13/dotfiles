{config, lib, pkgs, ...}:
{
  options.myHome.eww.enable = lib.mkEnableOption "enable eww";

  config = lib.mkIf config.myHome.eww.enable {
    home.packages = with pkgs; [
      eww
    ];

    # home.file = {
    #   "./config/eww/config" = {
    #     source = ./config;
    #   }
    # };
  };
}
