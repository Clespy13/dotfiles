{ config, pkgs, ... }:
{
  programs.oh-my-posh = {
    enable = true;
  };

  home = {
    file = {
      ".config/oh-my-posh" = {
        source = ./oh-my-posh;
        recursive = true;
      };
    };
  };
}
