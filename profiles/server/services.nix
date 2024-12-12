{ config, pkgs, lib, inputs, ...}:
{
  systemd.services = {
    "dyndns" = {
       path = with pkgs; [ 
         dig 
         curl
       ];
       script = ''
         HOST=dyndns.clespy.fr
         
         LOGIN=$(cat ${config.sops.secrets."dyndns/login".path})
         PASSWORD=$(cat ${config.sops.secrets."dyndns/password".path})
         
         HOST_IP=$(dig +short $HOST)
         CURRENT_IP=$(curl ifconfig.co)
         
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
         		RES=$(curl --user "$LOGIN:$PASSWORD" "https://dns.eu.ovhapis.com/nic/update?system=dyndns&hostname=$HOST&myip=$CURRENT_IP")
         		echo "Result request DynHost: $RES" 
         	else
         		echo "IP has not changed" 
         	fi
         fi
       '';
       serviceConfig = {
         User = config.users.users.server.name;
       };
       startAt = "*-*-* *:10:00";
     };
  };
}
