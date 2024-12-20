{config, lib, pkgs, ...}:
{
  services.jellyfin.enable = true;

  services.radarr.enable = true;
  services.sonarr.enable = true;
  services.bazarr.enable = true;
  services.prowlarr.enable = true;
  services.lidarr.enable = true;

  services.transmission = {
    enable = true;
    settings = {
      rpc-host-whitelist-enabled = true;
      rpc-host-whitelist = "127.0.0.1,10.100.0.*,*.local.clespy.fr";
      download-dir = "/media/downloads";
    };
  };

  users.users.radarr.extraGroups = [ "media" ];
  users.users.sonarr.extraGroups = [ "media" ];
  users.users.bazarr.extraGroups = [ "media" ];
  users.users.lidarr.extraGroups = [ "media" ];
  users.users.transmission.extraGroups = [ "media" ];
}
