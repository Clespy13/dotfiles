{ inputs, unstable, outputs, config, lib, pkgs, ... }:
{
  options.mySystem = {
    user = {
      name = lib.mkOption {
        default = "longer";
        type = lib.types.str;
      };
      sshKey = lib.mkOption {
	default = "";
        type = lib.types.str;
      };
    };

    myPackages = {
      enable = lib.mkEnableOption "default packages";
    };

    home-manager = {
      enable = lib.mkEnableOption "home-manager";
      home = lib.mkOption {
        type = lib.types.path;
        default = ../home-manager;
      };
    };
  };

  config = {

    fonts.packages = with pkgs; lib.mkIf config.mySystem.myPackages.enable [
      fira-code
      fira-code-symbols
      font-awesome
      dejavu_fonts
      ipafont
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerdfonts
      source-code-pro
      twemoji-color-font
    ];

    virtualisation.docker = lib.mkIf config.mySystem.myPackages.enable  {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    environment.systemPackages = with pkgs; lib.mkIf config.mySystem.myPackages.enable [
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

      dotnet-sdk_7
      dotnet-runtime_7
      dotnet-aspnetcore_7
      dotnetbuildhelpers
      dotnetPackages.Nuget
      ntfs3g
      zulu
      zulu11
      zulu17
      zulu8
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

    xdg.portal = lib.mkIf config.mySystem.myPackages.enable {
      enable = true;
      wlr.enable = true;
      config.common.default = [ "gtk" ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };

    # sound.enable = lib.mkIf config.mySystem.myPackages.enable true;
    security.rtkit.enable = lib.mkIf config.mySystem.myPackages.enable true;
    services.pipewire = lib.mkIf config.mySystem.myPackages.enable {
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

    environment.variables = lib.mkIf config.mySystem.myPackages.enable {
        ACLOCAL_PATH = "${pkgs.autoconf-archive}/share/aclocal:${pkgs.autoconf}/share/aclocal:${pkgs.automake}/share/aclocal";
      };

    environment.sessionVariables.DEFAULT_BROWSER = lib.mkIf config.mySystem.myPackages.enable "${pkgs.brave}/bin/brave";

    home-manager = lib.mkIf config.mySystem.home-manager.enable {
      useGlobalPkgs = lib.mkDefault true;
      useUserPackages = lib.mkDefault true;
      extraSpecialArgs = { inherit inputs unstable outputs; };
      sharedModules = builtins.attrValues outputs.homeManagerModules;
      users."${config.mySystem.user}" = import config.mySystem.home-manager.home;
    };

    users = {
      defaultUserShell = pkgs.zsh;
      users.${config.mySystem.user.name} = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" "scanner" "lp" ];
        openssh.authorizedKeys.keys = [ "${config.mySystem.user.sshKey}" ];
      };
    };

    programs.zsh = {
      enable = true; # Workaround for https://github.com/nix-community/home-manager/issues/2751
      enableCompletion = false;
    };
  };
}
