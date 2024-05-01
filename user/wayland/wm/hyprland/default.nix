{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = { };
    extraConfig = ''
      exec-once = dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY
      exec-once = GOMAXPROCS=1 syncthing --no-browser
      exec-once = hyprctl setcursor phinger-cursors-dark 24
      exec-once = ${pkgs.foot}/bin/foot --server
      exec-once = waybar
      # exec-once = swaybg -m fill -i $HOME/.wallpaper.png
      exec-once = swayidle -w timeout 900 "${pkgs.swaylock-effects}/bin/swaylock" timeout 910 '${pkgs.hyprland}/bin/hyprctl dispatch dpms off' resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' before-sleep "${pkgs.swaylock-effects}/bin/swaylock"
      exec-once = swww init
      exec = swww img $HOME/.wallpaper.png

      # monitor = eDP-1, preferred, auto, auto
      # monitor = eDP-1, 2256x1504, 0x0, 1.175000
      monitor = eDP-1, 2256x1504, 0x0, 1.333333
      monitor = DP-1, 2560x1440, auto, 1
      monitor = DP-2, 2560x1440, auto, 1

      input {
        kb_layout=us
        kb_options=ctrl:nocaps
        follow_mouse=2
        repeat_rate=50
        repeat_delay=250
        numlock_by_default=1
        force_no_accel=false
        sensitivity=0.33
        accel_profile=adaptive
      
        touchpad {
          disable_while_typing=true
          natural_scroll = no
          clickfinger_behavior=true
        }
      }
      
      debug {
        damage_tracking=2
      }
      
      general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        sensitivity=1
        border_size=2
        gaps_in=4
        gaps_out=8
        col.active_border=0x997E9CD8
        col.inactive_border=0x66333333
        # col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        # col.inactive_border = rgba(595959aa)
        layout=dwindle
      }
      
      decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 4
      
        active_opacity = 0.9
        inactive_opacity = 0.9
      
        blur:enabled = true
        blur:size = 3
        blur:passes = 3
        blur:new_optimizations = true
      
        drop_shadow = true
        shadow_offset = 2 2
        shadow_range = 4
        shadow_render_power = 2
        col.shadow = 0x66000000
        # col.shadow = rgba(1a1a1aee)
      
        blurls = gtk-layer-shell
        # blurls = waybar
        blurls = lockscreen
      }

      animations {
        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        enabled = yes
      
        bezier=easein,0.11, 0, 0.5, 0
        bezier=easeout,0.5, 1, 0.89, 1
        bezier=easeinout,0.45, 0, 0.55, 1
      
        animation=windowsIn,1,3,easeout,slide
        animation=windowsOut,1,3,easein,slide
        animation=windowsMove,1,3,easeout
        animation=fadeIn,1,3,easeout
        animation=fadeOut,1,3,easein
        animation=fadeSwitch,1,3,easeout
        animation=fadeShadow,1,3,easeout
        animation=fadeDim,1,3,easeout
        animation=border,1,3,easeout
        animation=workspaces,1,2,easeout,slide
      
        # Titus Animations
        # bezier = overshot, 0.05, 0.9, 0.1, 1.05
        # bezier = smoothOut, 0.36, 0, 0.66, -0.56
        # bezier = smoothIn, 0.25, 1, 0.5, 1
        #
        # animation = windows, 1, 5, overshot, slide
        # animation = windowsOut, 1, 4, smoothOut, slide
        # animation = windowsMove, 1, 4, default
        # animation = border, 1, 10, default
        # animation = fade, 1, 10, smoothIn
        # animation = fadeDim, 1, 10, smoothIn
        # animation = workspaces, 1, 6, default
      }
      
      dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        no_gaps_when_only = false
        pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true # you probably want this
      }
      
      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }
      
      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      misc {
        # Disable default hyprland bg
        disable_hyprland_logo = true
      }

      $mod = SUPER

      bind = CTRL ALT, L, exec, ${pkgs.swaylock-effects}/bin/swaylock
      bind = $mod, Return, exec, ${pkgs.foot}/bin/footclient
      bind = $mod, B, exec, ${pkgs.firefox}/bin/firefox
      bind = $mod SHIFT, R, exec, hyprctl reload && notify-send "Hyprland Reloaded"

      bind = $mod, D, exec, pkill anyrun || anyrun

      # Screenshots
      bind = ,Print, exec, grimblast --notify --cursor save area ~/Pictures/$(date ' + %Y-%m-%d ').png
      bind = $mod, Print, exec, grimblast --notify --cursor  copy area

      # Window Mgmt
      bind = $mod, Q, killactive
      bind = $mod, F, fullscreen,
      bind = $mod, Space, togglefloating,
      bind = $mod, P, pseudo, # dwindle
      bind = $mod, S, togglesplit, # dwindle
      
      # Move focus with mainMod + arrow keys
      bind = $mod, left, movefocus, l
      bind = $mod, right, movefocus, r
      bind = $mod, up, movefocus, u
      bind = $mod, down, movefocus, d

      # Focus
      bind = $mod, h, movefocus, l
      bind = $mod, l, movefocus, r
      bind = $mod, k, movefocus, u
      bind = $mod, j, movefocus, d
      
      # Move
      bind = $mod SHIFT,left,movewindow,l
      bind = $mod SHIFT,right,movewindow,r
      bind = $mod SHIFT,up,movewindow,u
      bind = $mod SHIFT,down,movewindow,d
      
      # Window Resize
      bind=CTRL,right,resizeactive,20 0
      bind=CTRL,left,resizeactive,-20 0
      bind=CTRL,up,resizeactive,0 -20
      bind=CTRL,down,resizeactive,0 20

      # Volume
      bindle=,XF86AudioLowerVolume,exec,pamixer -d 10
      bindle=,XF86AudioRaiseVolume,exec,pamixer -i 10
      bindl=,XF86AudioMute,exec,pamixer -t
      bindl=,XF86AudioMicMute,exec,pamixer --default-source -t

      # Backlight
      bindle = , XF86MonBrightnessDown, exec, brightnessctl s 10%-
      bindle = , XF86MonBrightnessUP, exec, brightnessctl s +10%

      # Switch workspaces with mainMod + [0-9]
      bind = $mod, 1, workspace, 1
      bind = $mod, 2, workspace, 2
      bind = $mod, 3, workspace, 3
      bind = $mod, 4, workspace, 4
      bind = $mod, 5, workspace, 5
      bind = $mod, 6, workspace, 6
      bind = $mod, 7, workspace, 7
      bind = $mod, 8, workspace, 8
      bind = $mod, 9, workspace, 9
      bind = $mod, 0, workspace, 10
      
      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mod SHIFT, 1, movetoworkspace, 1
      bind = $mod SHIFT, 2, movetoworkspace, 2
      bind = $mod SHIFT, 3, movetoworkspace, 3
      bind = $mod SHIFT, 4, movetoworkspace, 4
      bind = $mod SHIFT, 5, movetoworkspace, 5
      bind = $mod SHIFT, 6, movetoworkspace, 6
      bind = $mod SHIFT, 7, movetoworkspace, 7
      bind = $mod SHIFT, 8, movetoworkspace, 8
      bind = $mod SHIFT, 9, movetoworkspace, 9
      bind = $mod SHIFT, 0, movetoworkspace, 10
      
      # Scroll through existing workspaces with mainMod + scroll
      bind = $mod, mouse_down, workspace, e+1
      bind = $mod, mouse_up, workspace, e-1
      
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow

      xwayland {
	      force_zero_scaling = true
      }
    '';
    xwayland = { enable = true; };
    systemd = { enable = true; };
  };
}
