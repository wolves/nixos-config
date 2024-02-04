{ config, lib, pkgs, ... }:

{
  imports = [
    ./pipewire.nix
    ./dbus.nix
    ./gnome-keyring.nix
    ./fonts.nix
  ];

  environment.systemPackages = [ pkgs.wayland ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "ctrl:nocaps";
    };
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
