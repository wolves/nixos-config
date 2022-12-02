{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    grim
    libnotify
    light
    pamixer
    #mpvpaper
    slurp
    swappy
    swaybg
    swayidle
    swaylock-fancy
    wl-clipboard
    wlr-randr
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
  # environment = {
  #   loginShellInit = ''
  #     if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  #       exec Hyprland
  #     fi
  #   '';
  #   variables = {
  #     XDG_CURRENT_DESKTOP="Hyprland";
  #     XDG_SESSION_TYPE="wayland";
  #     XDG_SESSION_DESKTOP="Hyprland";
  #   };
  # };
}
