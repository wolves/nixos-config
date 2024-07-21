{ config, lib, pkgs, ... }:

{
  imports = [
    ./keyring.nix
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

