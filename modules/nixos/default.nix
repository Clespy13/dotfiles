{ inputs, config, lib, pkgs, unstable, ... } :
{
  imports = [
    ./user.nix
    ./gaming.nix
    ./sddm
  ];

  config = with lib; {
    # Bootloader.
    boot = {
      kernelModules = [ "nvidia" "nvidia_drm" ];
      kernelParams = [
        "usbcore.autosuspend=-1"
      ];
      kernelPackages = pkgs.linuxPackages_6_11;
      supportedFilesystems = [ "ntfs" ];
      # initrd.verbose = false;
      # consoleLogLevel = 0;

      # bootspec.enable = true;

      loader = {
        systemd-boot.enable = mkDefault true;
        efi.canTouchEfiVariables = mkDefault true;
      };
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnsupportedSystem = mkDefault true;

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Paris";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };

    # Configure keymap in X11
    services.xserver = {
      xkb.layout = "fr";
      xkb.variant = "";
    };

    # Configure console keymap
    console.keyMap = "fr";

    fonts.packages = with pkgs; [
      fira-code
      fira-code-symbols
      font-awesome
      dejavu_fonts
      ipafont
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
      source-code-pro
      twemoji-color-font
    ];

    nixpkgs.config.permittedInsecurePackages = [
     "dotnet-sdk-wrapped-6.0.428"
     "dotnet-runtime-6.0.36"
     "dotnet-sdk-6.0.428"
    ];


    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      sbctl
      jq
      drm_info
      acpi
      acpid
      flatpak

      nix-prefetch-git
      gparted
      xorg.xhost

      vim
      wget
      sway-contrib.grimshot
      ncdu
      vscode.fhs
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
      libsForQt5.kwayland-integration
      libsForQt5.kwayland
      libsForQt5.qt5ct
      libva
      libva1
      libva-utils
      libdrm
      mesa
      vaapiVdpau
      nvidia-vaapi-driver
      intel-vaapi-driver
      intel-media-driver
      linuxHeaders
      linux-firmware
      pciutils
      nvtopPackages.full

      pamixer
      playerctl
      pavucontrol

      cmake
      docker

      # for java
      jetbrains.idea-ultimate
      maven
      openjdk17-bootstrap
      jdk17

      wdisplays

      brightnessctl
      libnotify
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
      )
      brave
      vesktop
    ];

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      config.common.default = [ "gtk" ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.extraConfig = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        };
      };
    };

    environment.variables = {
      ACLOCAL_PATH = "${pkgs.autoconf-archive}/share/aclocal:${pkgs.autoconf}/share/aclocal:${pkgs.automake}/share/aclocal";
    };

    environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";

    programs.nix-ld.enable = true;

    #system.stateversion = "23.11";
  };
}
