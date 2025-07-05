{ config, pkgs, lib, inputs, ...}:
{
  systemd.services = {
    "dyndns" = {
       path = with pkgs; [ 
         dig 
         curl
       ];
       script = ''
         HOST=wg.clespy.fr
         
         TOKEN=$(cat ${config.sops.secrets."dyndns/password".path})
	 ZONE_ID=$(cat ${config.sops.secrets."dyndns/zoneid".path})
	 DNS_RECORD_ID=$(cat ${config.sops.secrets."dyndns/recordid".path})
         
         HOST_IP=$(dig +short $HOST)
         CURRENT_IP=$(curl api.ipify.org)
         
         echo "Run dyndns"
         echo "Current IP: $CURRENT_IP" 
         echo "Host IP: $HOST_IP" 
         
         if [ -z $CURRENT_IP ] || [ -z $HOST_IP ]
         then
         	echo "No IP retrieved" 
         else
         	if [ "$HOST_IP" != "$CURRENT_IP" ]
         	then
         		echo "IP has changed" 
         		RES=$(curl https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID -X PATCH \
			      -H 'Content-Type: application/json' \
                              -H "Authorization: Bearer $TOKEN" \
	                      -d "{\"type\":\"A\",\"name\":\"$HOST\",\"content\":\"$CURRENT_IP\",\"proxied\": false}")
         		echo "Result request DynHost: $RES" 
         	else
         		echo "IP has not changed" 
         	fi
         fi
       '';
       serviceConfig = {
         User = config.users.users.server.name;
       };
       startAt = "*:0/10:00";
     };
    # "tunnel" = {
    #   wantedBy = [ "multi-user.target" ];
    #   after = [ "network.target" ];
    #   path = with pkgs; [ 
    #     cloudflared
    #   ];
    #   script = ''
    #     cloudflared tunnel --no-autoupdate run --token $(cat ${config.sops.secrets."tunnel_token".path})
    #   '';
    #   serviceConfig = {
    #     Restart = "always";
    #     User = config.users.users.server.name;
    #   };
    # };
  };
}
