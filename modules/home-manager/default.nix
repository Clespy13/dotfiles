{pkgs, ...}:
{
  imports = [
    ./notifications
    ./wm
    ./applications
    ./code.nix
    ./hardware
    ./shell
  ];

  # notifications = import ./notifications;
  # wm = import ./wm;
  # applications = import ./applications;
  # code = import ./code.nix;
  # hardware = import ./hardware;
  # shell = import ./shell;

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
    direnv
  ];
}
