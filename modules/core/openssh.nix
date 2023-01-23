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
      user = "wlvs";
      guiAddress = ":8384";
      openDefaultPorts = true;
      dataDir = "/home/wlvs/.local/share/syncthing";
      configDir = "/home/wlvs/.config/syncthing";
    };
  };
}
