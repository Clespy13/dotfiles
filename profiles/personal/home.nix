{ pkgs, unstable, ... }:
{
  home = rec {
    username = "clem";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "alacritty";
  };

  myHome = {
    code.enable = true;
    eww.enable = true;
    mako.enable = true;
    hyprland.enable = true;
    firefox.enable = true;
    #brave.enable = true;
    fzf.enable = true;
    misc.enable = true;
    nvim.enable = true;
    tmux.enable = true;
    waybar.enable = true;
    alacritty.enable = true;
    oh-my-posh.enable = true;
    zsh.enable = true;
  };

  home.packages = with pkgs; [
     kitty
     htop
     man-pages
     fastfetch
     unzip
     tree
     feh
     bat
     pipewire
     wireplumber
     ripgrep
     fd
     direnv
   ];
}
