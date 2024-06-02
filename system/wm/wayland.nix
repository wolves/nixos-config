{ config, lib, pkgs, ... }:

{
  imports = [
    ./pipewire.nix
    ./dbus.nix
    ./gnome-keyring.nix
    ./fonts.nix
  ];

  environment.systemPackages = [ pkgs.wayland ];

  services.greetd = let
    session = {
      command = "Hyprland";
      user = "wlvs";
    };
  in {
    enable = true;

    settings = {
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };
}
