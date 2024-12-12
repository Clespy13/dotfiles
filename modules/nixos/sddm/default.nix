{config, pkgs, lib, ...}:
{
  options.mySystem.sddm.enable = lib.mkEnableOption "sddm";

  config = lib.mkIf config.mySystem.sddm.enable {
    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
