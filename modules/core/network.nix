{
  config,
  pkgs,
  lib,
  ...
}: {
  networking = {
    #wireless.iwd.enable = true;
    nameservers = ["1.1.1.1" "1.0.0.1"];
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" "sb" ];
      allowedUDPPorts = [
        config.services.tailscale.port
        51820
      ];
      allowedTCPPorts = [ 22 ];
      checkReversePath = "loose";
    };
    wireguard = {
      enable = true;
    };
  };
  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
}
