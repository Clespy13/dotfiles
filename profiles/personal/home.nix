{ config, pkgs, unstable, outputs, ... }:
{
  imports =
  [
  ]
  ++ (builtins.attrValues outputs.homeManagerModules);

  home.username = "clem";
  home.homeDirectory = "/home/clem";

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "alacritty";
  };

  notifications = {
    mako.enable = true;
  };
  hyprland.enable = true;
  firefox.enable = true;
  #brave.enable = true;
  fzf.enable = true;
  code.enable = true;
  misc.enable = true;
  nvim.enable = true;
  tmux.enable = true;
  waybar.enable = true;
  bluetooth.enable = true;
  alacritty.enable = true;
  oh-my-posh.enable = true;
  zsh.enable = true;
}
