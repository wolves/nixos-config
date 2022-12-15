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

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 610;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
    ];
  };

  # start swayidle as part of hyprland, not sway
  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    # extraConfig = builtins.readFile ./hyprland.conf;
  };
}
