{ config, lib, pkgs, ... }:

let 
  facadeIP = "167.172.133.184";
in {
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
    # Accept all connections from wireguard peer, facade.
    extraCommands = 
      '' 
      iptables -I INPUT -p tcp -s 10.100.0.1 -j ACCEPT
      # From X1C7 as well
      iptables -I INPUT -p tcp -s 10.100.0.3 -j ACCEPT
      '';
  };

  # Wireguard client
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.2/24" ];
      listenPort = 51820;
      privateKeyFile = " /home/srid/nix-config/private-config/wireguard/bornagain/private";
      peers = [
        { publicKey = "cInHQG7ns2Hvq7HW6kqVGoRXvoZALNZ00pvjH1bPTmM=";
          allowedIPs = [ "10.100.0.1/32" ];
          endpoint = "${facadeIP}:51820";
          persistentKeepalive = 25;
        }
        # x1c7
        { publicKey = "tDRqfSwIocf6VCutSzc6McEq38oZV/HpF1Yh1o85zSE=";
          allowedIPs = [ "10.100.0.3/32" ];
        }
      ];
    };
  };

}
