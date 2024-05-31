{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    exec-once = [
      "dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY"
      "GOMAXPROCS=1 syncthing --no-browser"
      "hyprctl setcursor phinger-cursors-dark 24"
      "waybar"

      "swww init"
      "swww img $HOME/.wallpaper.png"

      "hyprctl dispatch exec [workspace 1 silent] ${pkgs.foot}/bin/foot"
      "hyprctl dispatch exec [workspace 2 silent] ${pkgs.firefox}/bin/firefox"
    ];

    general = {
        sensitivity = 1;
        border_size = 2;
        gaps_in = 4;
        gaps_out = 8;
        layout = "dwindle";

        "col.active_border" = "0x997E9CD8";
        "col.inactive_border" = "0x66333333";
    };

    decoration = {
      rounding = 4;

      blur = {
        enabled = true;
        size = 3;
        passes = 3;
        new_optimizations = true;
      };

      active_opacity = 0.9;
      inactive_opacity = 0.9;
      drop_shadow = true;
      shadow_offset = "2 2";
      shadow_range = 4;
      shadow_render_power = 2;
      "col.shadow" = "0x66000000";
    };

    animations = {};
  };
}
