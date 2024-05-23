{ config, pkgs, ... }:

{
  imports =
    [
      ./zsh.nix
      ./wayland.nix
      ./nvim.nix
      ./waybar/waybar.nix
      ./mako/mako.nix
    ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "clem";
  home.homeDirectory = "/home/clem";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # wayland
    waybar
    swaylock
    wayidle
    wl-clipboard
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xwaylandvideobridge
    rofi-wayland
    qt6.qtwayland
    electron

    hyprpicker
    hyprpaper
    hypridle
    hyprlock
    hyprcursor

    #system
    htop
    man-pages
    fastfetch
    unzip
    oh-my-zsh
    tree
    feh
    bat
    alacritty
    pipewire
    wireplumber
    zoxide
    ripgrep
    fd

    #code
    automake
    cargo
    pkg-config
    autoconf
    autoconf-archive
    mako
    ninja
    meson
    meson-tools
    criterion
    gcc
    ltrace
    strace
    pre-commit
    gnumake
    git
    tig
    bear
    gdb
    clang-tools

    #npm
    nodejs_21

    #python
    python3
    python311Packages.pyyaml
    python311Packages.pytest
    python311Packages.pip

    #lua
    lua

    #misc
    poetry
    prismlauncher
    appflowy
    lolcat
    asciiquarium
    ocaml
    opam
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "alacritty";
  };

  programs.firefox = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env = { TERM = "alacritty"; };
      font = { normal = { family = "FiraCode"; }; size = 16.0; };
    };
  };

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

  systemd.user.services.mpris-proxy = {
    Unit = {
      Description =
        "Proxy forwarding Bluetooth MIDI controls via MPRIS2 to control media players";
      BindsTo = [ "bluetooth.target" ];
      After = [ "bluetooth.target" ];
    };

    Install.WantedBy = [ "bluetooth.target" ];

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
  };

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
