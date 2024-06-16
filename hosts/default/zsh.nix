{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "\\eOA" ];
      searchDownKey = [ "\\eOB" ];
    };

    envExtra = ''
      export PGDATA="$HOME/postgres_data"
      export PGHOST="/tmp"
      export DB_USERNAME="clem"
      export JAVA_HOME="$HOME/.nix-profile/lib/openjdk"
    '';

    loginExtra = ''
      [ "$(tty)" = "/dev/tty1" ] && exec Hyprland
    '';

    shellAliases = {
      update = "sudo nixos-rebuild boot --flake /home/$USER/.config/nixos#default";
      steam = "env --unset=SDL_VIDEODRIVER steam";
    };

    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "2d60a47cc407117815a1d7b331ef226aa400a344";
          sha256 = "1pnxr39cayhsvggxihsfa3rqys8rr2pag3ddil01w96kw84z4id2";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "custom-gnzh";
      custom = "$HOME/.omz";
      extraConfig = ''
        eval "$(zoxide init --cmd cd zsh)"
      '';
    };
  };
}
