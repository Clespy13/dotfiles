{pkgs, lib, config, ...}:
{
  options.misc.enable = lib.mkEnableOption "Enable misc apps";

  config = lib.mkIf config.misc.enable {
    home.packages = with pkgs; [
      prismlauncher
      unstable.appflowy
      lolcat
      asciiquarium
      spotify
      slack
    ];
  };
}
