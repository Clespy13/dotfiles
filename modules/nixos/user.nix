{ inputs, unstable, outputs, config, lib, pkgs, ... }:
{
  options.mySystem = {
    user = lib.mkOption {
      default = "longer";
      type = lib.types.str;
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

    home-manager = lib.mkIf config.mySystem.home-manager.enable {
      useGlobalPkgs = lib.mkDefault true;
      useUserPackages = lib.mkDefault true;
      extraSpecialArgs = { inherit inputs unstable outputs; };
      sharedModules = builtins.attrValues outputs.homeManagerModules;
      users."${config.mySystem.user}" = import config.mySystem.home-manager.home;
    };
    users = {
      defaultUserShell = pkgs.zsh;
      users.${config.mySystem.user} = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" "scanner" "lp" ];
      };
    };

    programs.zsh = {
      enable = true; # Workaround for https://github.com/nix-community/home-manager/issues/2751
      enableCompletion = false;
    };
  };
}
