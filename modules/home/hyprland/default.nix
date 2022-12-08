{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  # programs = {
  #   fish.loginShellInit = ''
  #     if test (tty) = "/dev/tty1"
  #       exec Hyprland &> /dev/null
  #     end
  #   '';
  # };
  home.packages = with pkgs; [
    grim
    libnotify
    brightnessctl
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
