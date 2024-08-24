{pkgs, ...}
{
  notifications = import ./notifications;
  wm = import ./wm;
  app = import ./app;
  code = import ./code.nix;
  hardware = import ./hardware;
  shell = import ./shell;

  home.packages = with pkgs; [
    htop
    man-pages
    fastfetch
    unzip
    tree
    feh
    bat
    pipewire
    wireplumber
    ripgrep
    fd
  ];
}
