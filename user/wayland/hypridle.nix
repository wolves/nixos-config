{ config, pkgs, ... }:

{
  services.hypridle = let
    hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
    hyprctl = "${pkgs.hyprland}/bin/hyprctl";
    loginctl = "${pkgs.systemd}/bin/loginctl";
  in {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || ${hyprlock}";
        before_sleep_cmd = "${loginctl} lock-session";
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "${loginctl} lock-session";
        }
        {
          timeout = 915;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
      ];
    };
  };
}
