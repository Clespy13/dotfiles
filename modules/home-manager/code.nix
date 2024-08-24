{pkgs, lib, config, ...}:
{
  options = {
    code.enable =
      lib.mkEnableOption "Enable coding utilities";
  };

  config = lib.mkIf config.code.enable {
    home.packages = with pkgs; [
      automake
      cargo
      pkg-config
      autoconf
      autoconf-archive
      mako
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
      python311
    ];
  };
}
