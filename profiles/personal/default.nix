{ config, pkgs, ...}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  mySystem = {
    user = {
      name = "clem";
      groups = ["networkmanager" "wheel" "video" "audio" "docker" "scanner" "lp"];
    };
    # my-packages.enable = true;
    home-manager = {
      enable = true;
      home = ./home.nix;
    };
    gaming.enable = true;
  };

  programs.dconf.enable = true;

  system.stateVersion = "23.11";
}
