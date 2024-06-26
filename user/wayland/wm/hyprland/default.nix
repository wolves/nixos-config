{ config, pkgs, ... }:

{
  imports = [
    ./binds.nix  
    ./rules.nix
    ./settings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;
    systemd.enable = true;
  };
}
