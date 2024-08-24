{ config, lib, pkgs, ... }:
{
  options = {
    oh-my-posh.enable =
      lib.mkEnableOption "Enable Oh-My-Posh";
  };

  config = lib.mkIf config.oh-my-posh.enable {
    programs.oh-my-posh = {
      enable = true;
    };

    home = {
      file = {
        ".config/oh-my-posh" = {
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
