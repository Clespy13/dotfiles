{config, lib, pkgs, ...}:
{
  programs.zsh = {
    enable = true;
    histSize = 10000;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };
}
