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
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
      allowedTCPPorts = [ 22 ];
      checkReversePath = "loose";
    };
  };
  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
}
