{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = let
    hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
    hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  in {
    "$mod" = "SUPER";

    exec-once = [
      "dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY"
      "${hyprctl} setcursor phinger-cursors-dark 24"
      "${hyprlock}"
      "GOMAXPROCS=1 syncthing --no-browser"
      "waybar"
      "swww init"

      # "${hyprctl} dispatch exec [workspace 1 silent] ${pkgs.foot}/bin/foot"
      "${hyprctl} dispatch exec [workspace 1 silent] ghostty"
      "${hyprctl} dispatch exec [workspace 2 silent] ${pkgs.brave}/bin/brave"
    ];

    exec = [
      "swww img $HOME/.cache/wallpaper.png"
    ];

    monitor = [
      # eDP-1, preferred, auto, auto
      # eDP-1, 2256x1504, 0x0, 1.175000

      "eDP-1, 2256x1504, 0x0, 1.333333"
      "DP-1, 2560x1440, auto, 1"
      "DP-2, 2560x1440, auto, 1"
    ];

    general = {
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

      shadow = {
        enabled = true;
        offset = "2 2";
        range = 4;
        render_power = 2;
        color = "0x66000000";
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "easein, 0.11, 0, 0.5, 0"
        "easeout, 0.5, 1, 0.89, 1"
        "easeinout, 0.45, 0, 0.55, 1"
      ];

      animation = [
        "windowsIn, 1, 3, easeout, slide"
        "windowsOut, 1, 3, easein, slide"
        "windowsMove, 1, 3, easeout"
        "fadeIn, 1, 3, easeout"
        "fadeOut, 1, 3, easein"
        "fadeSwitch, 1, 3, easeout"
        "fadeShadow, 1, 3, easeout"
        "fadeDim, 1, 3, easeout"
        "border, 1, 3, easeout"
        "workspaces, 1, 2, easeout, slide"
      ];
    };

    input = {
      kb_layout = "us";
      kb_options = "ctrl:nocaps";
      follow_mouse = 2;
      repeat_rate = 50;
      repeat_delay = 250;
      numlock_by_default = 1;
      force_no_accel = false;
      sensitivity = 0.33;
      accel_profile = "adaptive";

      touchpad = {
        disable_while_typing = true;
        natural_scroll = false;
        clickfinger_behavior = true;
      };
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_status = "master";
    };

    gestures = {
      workspace_swipe = false;
    };

    misc = {
      # Disable default hyprland bg
      disable_hyprland_logo = true;
    };

    xwayland = {
      force_zero_scaling = true;
    };
  };
}
