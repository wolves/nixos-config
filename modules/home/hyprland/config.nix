{
  pkgs,
  default,
  ...
}: let
  emoji = "${pkgs.wofi-emoji}/bin/wofi-emoji";
  launcher = "wofi";
in {
  wayland.windowManager.hyprland.extraConfig = ''
    $mod=SUPER

    monitor=eDP-1,2256x1504@60,0x0,1.2
    monitor=eDP-1,addreserved,0,0,50,0

    workspace=eDP-1,1

    exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once=eww daemon
    exec-once=eww open bar
    exec-once=swaybg -i $HOME/wallpaper/aenami_escape_1k.jpg --mode fill
    exec-once=mako

    # touchpad gestures
    gestures {
      workspace_swipe = 1
      workspace_swipe_forever = 1
    }

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
        clickfinger_behavior=true
      }
    }

    general {
      main_mod=SUPER
      sensitivity=1
      border_size=3
      gaps_in=4
      gaps_out=8
      col.active_border=0x997E9CD8
      col.inactive_border=0x66333333
      layout=dwindle
    }

    decoration {
      rounding=0
      multisample_edges=true
      active_opacity=0.93
      inactive_opacity=0.93
      fullscreen_opacity=1
      blur=true
      drop_shadow=false
    }

    animations {
      enabled=true

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
    }

    dwindle {
      pseudotile=false
      force_split=2
    }

    debug {
      damage_tracking=2
    }

    windowrule=float,^(Rofi)$
    windowrule=float,title:^(Picture-in-Picture)$
    windowrule=float,title:^(Volume Control)$

    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    bind=SUPER,Return,exec,alacritty
    bind=SUPER,Q,killactive,
    bind = $mod, L, exec, loginctl lock-session
    bind=SUPER,Escape,exit,
    bind=SUPER,E,exec,pcmanfm
    #bind=SUPER,H,togglefloating,
    #bind=SUPER,D,exec,rofi -show drun
    bind=$mod,D,exec,wofi --show run --xoffset=1542 --yoffset=8 --width=320px --height=1228px --style=$HOME/.config/wofi.css --prompt=Run
    bind=SUPER,P,pseudo,
    bind=SUPER,F,fullscreen,
    bind=SUPER,R,forcerendererreload
    bind=SUPERSHIFT,R,exec,hyprctl reload

    bind=SUPER,h,movefocus,l
    bind=SUPER,l,movefocus,r
    bind=SUPER,k,movefocus,u
    bind=SUPER,j,movefocus,d

    bind=SUPERSHIFT,left,movewindow,l
    bind=SUPERSHIFT,right,movewindow,r
    bind=SUPERSHIFT,up,movewindow,u
    bind=SUPERSHIFT,down,movewindow,d

    bind=$mod,1,workspace,1
    bind=$mod,2,workspace,2
    bind=$mod,3,workspace,3
    bind=$mod,4,workspace,4
    bind=$mod,5,workspace,5
    bind=$mod,6,workspace,6
    bind=$mod,7,workspace,7
    bind=$mod,8,workspace,8
    bind=$mod,9,workspace,9
    bind=$mod,0,workspace,10
    bind=$mod,right,workspace,+1
    bind=$mod,left,workspace,-1

    bind=$mod SHIFT,1,movetoworkspace,1
    bind=$mod SHIFT,2,movetoworkspace,2
    bind=$mod SHIFT,3,movetoworkspace,3
    bind=$mod SHIFT,4,movetoworkspace,4
    bind=$mod SHIFT,5,movetoworkspace,5
    bind=$mod SHIFT,6,movetoworkspace,6
    bind=$mod SHIFT,7,movetoworkspace,7
    bind=$mod SHIFT,8,movetoworkspace,8
    bind=$mod SHIFT,9,movetoworkspace,9
    bind=$mod SHIFT,0,movetoworkspace,10
    bind=$mod SHIFT,right,movetoworkspace,+1
    bind=$mod SHIFT,left,movetoworkspace,-1

    bind=CTRL,right,resizeactive,20 0
    bind=CTRL,left,resizeactive,-20 0
    bind=CTRL,up,resizeactive,0 -20
    bind=CTRL,down,resizeactive,0 20

    bind=,print,exec,grim -g "$(slurp)" - | swappy -f - -o ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png && notify-send "Saved to ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png"

    bind=,XF86AudioLowerVolume,exec,pamixer -d 10
    bind=,XF86AudioRaiseVolume,exec,pamixer -i 10
    bind=,XF86AudioMute,exec,pamixer -t
    bind=,XF86AudioMicMute,exec,pamixer --default-source -t

    bind=,XF86MonBrightnessDown,exec,brightnessctl s 10%-
    bind=,XF86MonBrightnessUP,exec,brightnessctl s +10%
  '';
}
