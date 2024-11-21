{ config, lib, pkgs, ... }:
{
  options.myHome = {
    alacritty.enable =
      lib.mkEnableOption "Enable alacritty";
  };

  config = lib.mkIf config.myHome.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        env = { TERM = "alacritty"; };
        font = {
          normal = {
            family = "FiraCode";
          };
          size = 16.0;
        };
      };
    };
  };
}
