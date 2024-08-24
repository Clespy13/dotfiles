{pkgs, lib, config, ...}:
{
  options = {
    bluetooth.enable =
      lib.mkEnableOption "Enable bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {
    systemd.user.services.mpris-proxy = {
      Unit = {
        Description =
          "Proxy forwarding Bluetooth MIDI controls via MPRIS2 to control media players";
        BindsTo = [ "bluetooth.target" ];
        After = [ "bluetooth.target" ];
      };

      Install.WantedBy = [ "bluetooth.target" ];

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
      };
    };
  };
}
