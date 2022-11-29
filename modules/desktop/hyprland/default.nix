{ config, lib, pkgs, ... }:

{
  imports = [ ../../programs/waybar.nix ];

  services.dbus.enable = true;

  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland
      fi
    '';
    variables = {
      XDG_CURRENT_DESKTOP="Hyprland";
      XDG_SESSION_TYPE="wayland";
      XDG_SESSION_DESKTOP="Hyprland";
    };
    systemPackages = with pkgs; [
      grim
      light
      pamixer
      #mpvpaper
      slurp
      swappy
      swayidle
      swaylock-fancy
      wl-clipboard
      wlr-randr
    ];
  };

  programs = {
    hyprland.enable = true;
  };
}
