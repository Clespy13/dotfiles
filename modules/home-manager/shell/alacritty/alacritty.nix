{ config, lib, pkgs, ... }:
{
  options = {
    alacritty.enable =
      lib.mkEnableOption "Enable alacritty"
  };

  config = lib.mkIf config.alacritty.enable {
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
