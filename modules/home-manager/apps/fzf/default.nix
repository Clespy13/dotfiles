{ config, lib, pkgs, ... }:
{
  options.myHome.fzf.enable = lib.mkEnableOption "Enable fzf";

  config = lib.mkIf config.myHome.fzf.enable {
    programs.fzf = {
      enable = true;
    };
  };
}
