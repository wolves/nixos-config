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
    layout = "us";
    xkbVariant = "";
    xkbOptions = "ctrl:nocaps";
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
