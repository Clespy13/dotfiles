{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    zinit
  ];

  programs.zoxide.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "^[OA" "^[[A" ];
      searchDownKey = [ "^[OB" "^[[B"];
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

    initExtra = ''
      if [ -f $HOME/.zsh/test.sh ]; then
        source $HOME/.zsh/test.sh
      fi

      # Add in snippets
      zinit snippet OMZP::git
      zinit snippet OMZP::sudo
      zinit snippet OMZP::archlinux
      zinit snippet OMZP::aws
      zinit snippet OMZP::kubectl
      zinit snippet OMZP::kubectx
      zinit snippet OMZP::command-not-found

      eval "$(zoxide init --cmd cd zsh)"
      eval "$(fzf --zsh)"
      eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/config.toml)"
      eval $(dircolors -b)

      bindkey '^f' autosuggest-accept

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' menu no
    '';

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/$USER/.config/nixos#default";
      upgrade = "sudo nixos-rebuild boot --flake /home/$USER/.config/nixos#default --upgrade";
      steam = "env --unset=SDL_VIDEODRIVER steam";
      ls = "ls --color";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      ignoreAllDups = true;
      share = true;
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
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "14e16f0d36ae9938e28b2f6efdb7344cd527a1a6";
          sha256 = "0cp2f7qrggpn8sdi57v5a4qf8dbhqjc06py5ihxp5qkw76fn1j53";
        };
      }
    ];
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [ "git" ];
    #   theme = "gnzh";
    #   custom = "$HOME/.omz";
    #   extraConfig = ''
    #
    #
    #   '';
    # };
  };

  home = {
    file = {
      ".zsh" = {
        source = ./zsh;
        recursive = true;
      };
    };
  };
}
