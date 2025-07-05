{config, lib, pkgs, ...}:
let
  secrets = config.sops.secrets;
in
{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "6c9f1f6c-5ec1-4300-9844-9ac2b0c6cb64" = {
        credentialsFile = secrets."cloudflared/homelab".path;
	ingress = {
	  "clespy.fr" = "http://127.0.0.1:8080";
	  "www.clespy.fr" = "http://127.0.0.1:8080";
	  "notes.clespy.fr" = "http://127.0.0.1:8181";
	  "jellyfin.clespy.fr" = "http://127.0.0.1:8096";
	  "jellyseerr.clespy.fr" = "http://127.0.0.1:5055";
	  "authentik.clespy.fr" = "http://127.0.0.1:9001";
	  "glance.clespy.fr" = "http://127.0.0.1:61208";
      	  "vault.clespy.fr" = "http://127.0.0.1:8222";
	};
        default = "http_status:404";
      };
    };
  };

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
      default = {
        forceSSL = true;
        useACMEHost = "local.clespy.fr";
        default = true;
        serverName = "_";
	listenAddresses = [ "0.0.0.0" ];
        locations."/" = {
          return = "404";
        };
      };
    } // {
      "radarr.local.clespy.fr" = proxy 7878;
      "sonarr.local.clespy.fr" = proxy 8989;
      "bazarr.local.clespy.fr" = proxy 6767;
      "prowlarr.local.clespy.fr" = proxy 9696;
      "lidarr.local.clespy.fr" = proxy 8686;
      "homarr.local.clespy.fr" = proxy 7575;
      "transmission.local.clespy.fr" = proxy 9091;
      "flaresolverr.local.clespy.fr" = proxy 8191;
      "mealie.local.clespy.fr" = proxy 9000;
      "nextcloud.local.clespy.fr" = proxy 51821;
      "photos.local.clespy.fr" = proxy 2283;
    };
    # // {
    #   "nextcloud.clespy.fr" = {
    #     forceSSL = true;
    #     enableACME = true;
    #     locations."/".proxyPass = "http://127.0.0.1:51821/";
    #   };
    # };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@clespy.fr";
    certs = {
      "local.clespy.fr" = { 
        domain = "clespy.fr";
        email = "local+acme@clespy.fr";
        extraDomainNames = [ "*.local.clespy.fr" ];
        dnsProvider = "cloudflare";
        dnsPropagationCheck = true;
        credentialFiles = {
		"CF_DNS_API_TOKEN_FILE" = "${secrets."cf/api_token".path}";
	};
      };
    };
  };

  users.users.nginx.extraGroups = [ "acme" ];
}
