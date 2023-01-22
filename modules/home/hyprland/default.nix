{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [./config.nix];

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
    swaylock-effects
    wl-clipboard
    wlr-randr
    wofi
  ];

  # start swayidle as part of hyprland, not sway
  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    # extraConfig = builtins.readFile ./hyprland.conf;
  };
}
