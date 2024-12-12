{ inputs, config, lib, pkgs, ... } :
{
  imports = [
    ./user.nix
    ./gaming.nix
  ];

  config = with lib; {
    # Bootloader.
    boot = {
      kernelModules = [ "nvidia" "nvidia_drm" ];
      kernelParams = [
        "usbcore.autosuspend=-1"
      ];
      kernelPackages = pkgs.linuxPackages_latest;
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
      xkb.variant = "azerty";
    };

    # Configure console keymap
    console.keyMap = "fr";

    #system.stateversion = "23.11";
  };
}
