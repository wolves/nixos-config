{ config, pkgs, ... }:

{
  imports = [
    ./binds.nix  
    ./rules.nix
    ./settings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      exec-once = swayidle -w timeout 900 "${pkgs.swaylock-effects}/bin/swaylock" timeout 910 '${pkgs.hyprland}/bin/hyprctl dispatch dpms off' resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' before-sleep "${pkgs.swaylock-effects}/bin/swaylock"

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
      
      decoration {
        blurls = gtk-layer-shell
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

      xwayland {
	      force_zero_scaling = true
      }
    '';
    xwayland = { enable = true; };
    systemd = { enable = true; };
  };
}
