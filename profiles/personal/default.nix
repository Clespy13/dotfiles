{ config, pkgs, ...}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  mySystem = {
    user = "clem";
    home-manager = {
      enable = true;
      home = ./home.nix;
    };
    gaming.enable = true;
  };

  programs.dconf.enable = true;

  system.stateVersion = "23.11";
}
