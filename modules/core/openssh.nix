{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    openssh.enable = true;
    tailscale.enable = true;

    syncthing = {
      enable = true;
      group = "users";
      guiAddress = ":8384";
      openDefaultPorts = true;
    };
  };
}
