{pkgs, lib, config, unstable, ...}:
{
  options.myHome.misc.enable = lib.mkEnableOption "Enable misc apps";

  config = lib.mkIf config.myHome.misc.enable {
    home.packages = with pkgs; [
      prismlauncher
      appflowy
      lolcat
      asciiquarium
      spotify
      slack
    ];
  };
}
