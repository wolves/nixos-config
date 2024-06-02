{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bind = [
      "CTRL ALT, L, exec, ${pkgs.hyprlock}/bin/hyprlock"
      "$mod, Return, exec, ${pkgs.foot}/bin/foot"
      "$mod, B, exec, ${pkgs.firefox}/bin/firefox"
      "$mod SHIFT, R, exec, hyprctl reload && notify-send 'Hyprland Reloaded'"
      "$mod, D, exec, pkill anyrun || anyrun"

      # Screenshots
      ",Print, exec, grimblast --notify --cursor save area ~/Pictures/$(date ' + %Y-%m-%d ').png"
      "$mod, Print, exec, grimblast --notify --cursor  copy area"

      # Window Mgmt
      "$mod, Q, killactive"
      "$mod, F, fullscreen,"
      "$mod, Space, togglefloating,"
      "$mod, P, pseudo, # dwindle"
      "$mod, S, togglesplit, # dwindle"
      
      # Move focus with mainMod + arrow keys
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      # Focus
      "$mod, h, movefocus, l"
      "$mod, l, movefocus, r"
      "$mod, k, movefocus, u"
      "$mod, j, movefocus, d"
      
      # Move
      "$mod SHIFT,left,movewindow,l"
      "$mod SHIFT,right,movewindow,r"
      "$mod SHIFT,up,movewindow,u"
      "$mod SHIFT,down,movewindow,d"
      
      # Window Resize
      "CTRL,right,resizeactive,20 0"
      "CTRL,left,resizeactive,-20 0"
      "CTRL,up,resizeactive,0 -20"
      "CTRL,down,resizeactive,0 20"

      # special workspace
      "$mod SHIFT, grave, movetoworkspace, special"
      "$mod, grave, togglespecialworkspace, eDP-1"

      # Switch workspaces with mainMod + [0-9]
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"
      
      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"
      
      # Scroll through existing workspaces with mainMod + scroll
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

    ];

    bindl = [
      # Volume
      ",XF86AudioMute,exec,pamixer -t"
      ",XF86AudioMicMute,exec,pamixer --default-source -t"
    ];

    bindle = [
      # Volume
      ",XF86AudioLowerVolume,exec,pamixer -d 10"
      ",XF86AudioRaiseVolume,exec,pamixer -i 10"

      # Backlight
      ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ", XF86MonBrightnessUP, exec, brightnessctl s +10%"
    ];
  };
}
