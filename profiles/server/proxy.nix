{config, lib, pkgs, ...}:
let
  secrets = config.sops.secrets;
in
{
  # networking.firewall.allowedTCPPorts = [ 51821 ];

  services.nginx = {
    enable = true;
    package = pkgs.nginxStable.override { openssl = pkgs.libressl; };

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

    virtualHosts =
    let
      base = locations: {
        inherit locations;

        forceSSL = true;
        useACMEHost = "local.clespy.fr";
      };
      proxy = port: base {
        "/".proxyPass = "http://127.0.0.1:" + toString(port) + "/";
      };
    in
    {
      "vault.local.clespy.fr" = proxy 8222;
      "jellyfin.local.clespy.fr" = proxy 8096;
      "radarr.local.clespy.fr" = proxy 7878;
      "sonarr.local.clespy.fr" = proxy 8989;
      "bazarr.local.clespy.fr" = proxy 6767;
      "prowlarr.local.clespy.fr" = proxy 9696;
      "lidarr.local.clespy.fr" = proxy 8686;
      "transmission.local.clespy.fr" = proxy 9091;
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@clespy.fr";
    certs = {
      "local.clespy.fr" = { 
        domain = "clespy.fr";
        email = "local+acme@clespy.fr";
        extraDomainNames = [ "*.local.clespy.fr" ];
        dnsProvider = "ovh";
        dnsPropagationCheck = true;
        credentialsFile = "${secrets."ovh/app_creds".path}";
      };
    };
  };

  users.users.nginx.extraGroups = [ "acme" ];
}
