{ config, lib, pkgs, ... }:
{
  options = {
    fzf.enable =
      lib.mkEnableOption "Enable fzf";
  };

  config = lib.mkIf config.fzf.enable {
    programs.fzf = {
      enable = true;
    };
  };
}
