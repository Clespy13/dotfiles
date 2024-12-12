{ inputs, unstable, outputs, config, lib, pkgs, ... }:
{
  options.mySystem = {
    gaming = {
      enable = lib.mkEnableOption "gaming";
    };
  };

  config = {
    # hardware = lib.mkIf config.mySystem.gaming.enable {
    #   nvidia = {
    #     package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #       version = "555.58.02";
    #       sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
    #       sha256_aarch64 = "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
    #       openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
    #       settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
    #       persistencedSha256 = "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
    #     };
    #     forceFullCompositionPipeline = true;
    #     nvidiaSettings = true;
    #     modesetting.enable = true;
    #     open = false;
    #     prime = {
    #       offload = {
    #         enable = true;
    #         enableOffloadCmd = true;
    #       };
    #       intelBusId = "PCI:0:2:0";
    #       nvidiaBusId = "PCI:1:0:0";
    #       reverseSync.enable = true;
    #     };
    #     powerManagement.enable = true;
    #     powerManagement.finegrained = true;
    #   };
    #   graphics = {
    #     package = unstable.mesa.drivers;
    #     package32 = unstable.pkgsi686Linux.mesa.drivers;
    #     enable = true;
    #     # driSupport = true;
    #     # driSupport32Bit = true;
    #     extraPackages = with pkgs; [
    #       libva
    #       vaapiVdpau
    #       # mesa.drivers
    #     ];
    #   };
    #   opentabletdriver.enable = true;
    # };

    nixpkgs.config.permittedInsecurePackages = [
      "dotnet-runtime-wrapped-6.0.36"
      "dotnet-runtime-6.0.36"
      "dotnet-sdk-wrapped-6.0.428"
      "dotnet-sdk-6.0.428"
    ];

    services = {
      auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };

      dbus = {
        enable = true;
        packages = [ pkgs.gcr ];
      };

    };

    # services.xserver.videoDrivers = [ "nvidia" ];

    #hardware.bluetooth.enable = true;
    #hardware.bluetooth.powerOnBoot = true;
    #hardware.pulseaudio.enable = true;
    services.blueman.enable = true;

    programs.light.enable = true;

    security.polkit.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    programs.dconf.enable = true;

    powerManagement.enable = true;
    powerManagement.powertop.enable = true;

    ## Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    #  networking.firewall.allowedTCPPorts = [ 22 ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall.enable = false;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # hardware = {
    #   sane = {
    #     enable = true;
    #     brscan4 = {
    #       enable = true;
    #       netDevices = {
    #         home = { model = "DCP-J752DW"; ip = "192.168.001.013"; };
    #       };
    #     };
    #   };
    # };


    xdg.mime.defaultApplications = {
      "text/html" = "brave.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
    };
  };
}
