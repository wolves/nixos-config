{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    openssh.enable = true;
    tailscale.enable = true;
  };
}
