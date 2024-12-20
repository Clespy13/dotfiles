{ config, pkgs, lib, inputs, ...}:
{
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    ./vpn.nix
    ./proxy.nix
    ./vault.nix
    ./zsh.nix
    ./media.nix
    inputs.sops-nix.nixosModules.sops
  ];

  mySystem = {
    user = {
      name = "server";
      sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB0xxARWrpShMEMg5BBvQZh1hUAdnJor4exhINClZnd7";
    };
  };

  # Bootloader.
  # boot = lib.mkOverride {
  #   loader = {
  #     systemd-boot.enable = true;
  #     efi.canTouchEfiVariables = true;
  #   };
  # };

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    ripgrep
    git
    dig
    sops
  ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/server/.config/sops/age/keys.txt";
    };

    secrets = {
      "dyndns/login" = {
         owner = config.users.users.server.name;
       };
      "dyndns/password" = {
         owner = config.users.users.server.name;
       };
      "wg0/priv_key" = {
         owner = config.users.users.server.name;
      };
      "ovh/app_creds" = {
         owner = config.users.users.server.name;
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 6315 ];
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  users.users.server.extraGroups = [ "docker" ];

  # services.getty.autologinUser = "server";
  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
        {
          command = "/run/current-system/sw/bin/reboot";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-wrapped-6.0.36"
    "aspnetcore-runtime-6.0.36"
    "dotnet-sdk-wrapped-6.0.428"
    "dotnet-sdk-6.0.428"
  ];

  system.stateVersion = "24.11";
}
