{ config, pkgs, lib, inputs, ...}:
with lib;
let
 secrets = config.sops.secrets;
 setclients = {
   "10.100.0.2" = "192.168.1.14";
   "10.100.0.3" = "192.168.1.15";
   "10.100.0.4" = "192.168.1.20";
 };
in
{
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  systemd.services.NetworkManager-wait-online.enable = false; # temporary waiting for nixos to fix the bug

  networking = {
    nat = {
      enable = true;
      externalInterface = "enp1s0";
      internalInterfaces = [ "wg0" ];
    };
    # firewall.allowedUDPPorts = [ 51820 ];

    nftables.enable = true;
    nftables.tables.gateway-nat =
        let
          clients = attrsets.mapAttrsToList (vpnAddr: lanAddr: "ip daddr ${vpnAddr} dnat to ${lanAddr};") setclients;
        in
        {
          content = ''
            chain postrouting {
                type nat hook postrouting priority 100;
            }

            chain prerouting {
                type nat hook prerouting priority -100;
                ${strings.concatStringsSep "\n" clients}
            }
          '';

          family = "inet";
        };

    
    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          ips = [ "10.100.0.1/24" ];
          listenPort = 51820;

          # Path to the private key file.
          privateKeyFile = secrets."wg0/priv_key".path;

          peers = [
            { # Clespy's PC
              publicKey = "L2jfnwsxATfs/Pr+ZtVuexOZRjR99yAH8b+/3sJtvGI=";
              allowedIPs = [ "10.100.0.2/32" ];
            }
            { # Clespy's Phone
              publicKey = "eEAxBdoyFv3usV42YORDB/dWwEzRu23zFo8Qc5mT5Ak=";
              allowedIPs = [ "10.100.0.3/32" ];
            }
            { # Kolowy's PC
              publicKey = "kmJnypr1aiJjx7k5he8cKwzLgU5GL9N2g45WOsPIkkg=";
              allowedIPs = [ "10.100.0.4/32" ];
            }
          ];
        };
      };
    };
  };
}
