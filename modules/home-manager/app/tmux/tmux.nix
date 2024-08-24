{ config, lib, pkgs, ... }:
{
  options = {
    tmux.enable =
      lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      baseIndex = 1;
      prefix = "C-space";
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
      plugins = with pkgs.tmuxPlugins; [
        (catppuccin.overrideAttrs (_: {
          src = pkgs.fetchFromGitHub {
            owner = "dreamsofcode-io";
            repo = "catppuccin-tmux";
            rev = "b4e0715356f820fc72ea8e8baf34f0f60e891718";
            sha256 = "03q8vi4i62cm1al7ba2r9l0bnxhp51qacydpd0qhr234nblcr48l";
          };
        }))
        yank
        vim-tmux-navigator
        sensible
      ];
      extraConfig = ''
        set -g mouse on

        # Vim style pane selection
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Use Alt-arrow keys without prefix key to switch panes
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # Shift arrow to switch windows
        bind -n S-Left  previous-window
        bind -n S-Right next-window

        # Shift Alt vim keys to switch windows
        bind -n M-H previous-window
        bind -n M-L next-window

        set -g @catppuccin_flavour 'mocha'

        # set vi-mode
        set-window-option -g mode-keys vi
        # keybindings
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"

        bind -n C-l send-keys 'C-l'

        bind v split-window -v -c "#{pane_current_path}"
        bind h split-window -h -c "#{pane_current_path}"
        unbind '"'
        unbind %
      '';
    };
  };
}
