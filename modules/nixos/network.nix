{ config, pkgs, hostname, ... }:

{
  services.tailscale.enable = true;

  networking = {
    hostName = hostname;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    networkmanager.enable = true;

    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [
	      config.services.tailscale.port
      ];
      allowedTCPPorts = [ 22 ];
      checkReversePath = "loose";
    };

    wireguard.enable = true;

  };

  # Slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
}

