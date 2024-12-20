{pkgs, lib, config, ...}:
{
  options.myHome.code.enable = lib.mkEnableOption "Enable coding utilities";

  config = lib.mkIf config.myHome.code.enable {
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      automake
      cargo
      pkg-config
      autoconf
      autoconf-archive
      ninja
      meson
      meson-tools
      criterion
      gcc
      ltrace
      strace
      pre-commit
      gnumake
      git
      tig
      bear
      gdb
      clang-tools
      lua
      go
    ];
  };
}
