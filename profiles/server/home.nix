{ pkgs, unstable, ... }:
{
  home = rec {
    username = "server";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  myHome = {
    nvim.enable = true;
    zsh.enable = true;
  };
};
