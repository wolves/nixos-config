{ config, lib, pkgs, stdenv, toString, browser, term, font, ... }:

{
  imports = [
    ../../app/terminal/foot.nix
  ];

  home.packages = with pkgs; [
    foot
    feh
    killall
    polkit_gnome
    swaybg
    swayidle
    wl-clipboard
    hyprland-protocols
    gtklock
    wev
    fnott
    fuzzel
    grim
    slurp
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    pamixer
  ];

  home.file.".wallpaper.png".source = ../../../themes/aenami_escape.jpg;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = { };
    extraConfig = ''
      exec-once = dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY
      exec-once = GOMAXPROCS=1 syncthing --no-browser
      exec-once = ${pkgs.foot}/bin/foot --server
      exec-once = waybar
      exec-once = swaybg -m fill -i $HOME/.wallpaper.png
      exec-once = swayidle -w timeout 900 "${pkgs.gtklock}/bin/gtklock -d" timeout 910 '${pkgs.hyprland}/bin/hyprctl dispatch dpms off' resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' before-sleep "${pkgs.gtklock}/bin/gtklock -d"

      #monitor = eDP-1, preferred, auto, auto
      monitor = eDP-1, 2256x1504, 0x0, 1.25
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
        force_hypr_chan = false
      }

      $mod = SUPER

      bind = CTRL ALT, L, exec, ${pkgs.gtklock}/bin/gtklock -d
      bind = $mod, Return, exec, ${pkgs.foot}/bin/footclient
      bind = $mod, B, exec, ${pkgs.firefox}/bin/firefox
      bind = $mod SHIFT, R, exec, hyprctl reload && notify-send "Hyprland Reloaded"

      bind = $mod, D, exec, killall fuzzel || fuzzel

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

  programs.waybar = {
    enable = true;

    # use hyprctl to switch workspaces
    package = pkgs.waybar.overrideAttrs ( oldAttrs: {
      postPatch = ''
        sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprworkspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
        sed -i 's/gIPC->getSocket1Reply("dispatch workspace " + std::to_string(id()));/const std::string command = "hyprworkspace " + std::to_string(id());\n\tsystem(command.c_str());/g' src/modules/hyprland/workspaces.cpp
      '';
    });

    settings = {
      mainBar = {
	layer = "top";
	position = "top";
	height = 0;

        modules-left = [
	  "idle_inhibitor"
	  "hyprland/workspaces"
	];
	modules-center = [];
	modules-right = [
	  "tray"
	  "backlight"
	  "pulseaudio"
	  "pulseaudio#microphone"
	  "cpu"
	  "memory"
	  # "temperature"
	  "network"
	  "battery"
	  "clock"
	];

	"idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };

	"hyprland/workspaces" = {
          "format" = "{icon}";
          #"format-icons" = {
          #  "1" = "󱚌";
          #  "2" = "󰖟";
          #  "3" = "";
          #  "4" = "󰎄";
          #  "5" = "󰋩";
          #  "6" = "";
          #  "7" = "󰄖";
          #  "8" = "󰑴";
          #  "9" = "󱎓";
          #};
	  "persistant-workspaces" = {
	    "1" = [];
	    "2" = [];
	    "3" = [];
	    "4" = [];
	    "5" = [];
	    "6" = [];
	    "7" = [];
	    "8" = [];
	    "9" = [];
	  };
	  "all-outputs" = true;
	  "disable-scroll" = true;
	  "on-click" = "activate";
        };

        "tray" = {
          "icon-size" = 13;
          "spacing" = 10;
        };

        "backlight" = {
          #"device" = "acpi_video1";
          "format" = "{icon}  {percent}%";
          "format-icons" = [""];
        };

        "pulseaudio" = {
          "format" = "{icon}   {volume}%";
          "tooltip" = false;
          "format-muted" = " Muted";
          "on-click" = "pamixer -t";
          "on-scroll-up" = "pamixer -i 5";
          "on-scroll-down" = "pamixer -d 5";
          "scroll-step" = 5;
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
          };
        };

        "pulseaudio#microphone" = {
          "format" = "{format_source}";
          "format-source" = "  {volume}%";
          "format-source-muted" = " Muted";
          "on-click" = "pamixer --default-source -t";
          "on-scroll-up" = "pamixer --default-source -i 5";
          "on-scroll-down" = "pamixer --default-source -d 5";
          "scroll-step" = 5;
        };

	"cpu" = {
          "interval" = 15;
          "format" = "   {}%";
          "max-length" = 10;
	};

	"memory" = {
          "interval" = 30;
          "format" = "  {}%";
          "max-length" = 10;
	};

	"temperature" = {
    "critical-threshold" = 80;
    "format" = "{temperatureC}°C";
    #"format" = " {temperatureC}°C";
	};

	"network" = {
          #"interface" = "wlp2*"; # (Optional) To force the use of this interface
          #"format-wifi" = "{essid} ({signalStrength}%) <span font='18'>󰖩</span>";
          "format-wifi" = "󰖩   {signalStrength}%";
          "format-ethernet" = "Connected <span font='14'>󰈁</span>";
          "tooltip-format" = "{essid} ({signalStrength}%)\n{ifname} via {gwaddr}/{cidr}";
          "format-linked" = "{ifname} (No IP) <span font='14'>󰈁</span>";
          "format-disconnected" = "Disconnected <span font='14'>󰈂</span>";
          "format-alt" = "{ipaddr}";
          #"on-click" = "bash ~/.config/waybar/scripts/test.sh";
          "on-click" = "${pkgs.foot}/bin/footclient nmtui";
	};

	"battery" = {
          "states" = {
            "good" = 95;
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon}   {capacity}%";
          "format-charging" = " {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-alt" = "{time} {icon}";
          "format-icons" = ["" "" "" "" ""];
	};

	"clock" = {
          #"format" = "{: %R    %m/%d}";
          "format" = "{:%R}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
	};
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
	      font-family: FontAwesome, Product Sans;
        /* font-family: Cartograph CF Nerd Font, monospace; */
        /* font-weight: bold; */
        font-size: 14px;
        min-height: 0;
      }
      
      window#waybar {
        background: rgba(21, 18, 27, 0);
        color: #dcd7ba;
      }
      
      tooltip {
        background: #1e1e2e;
        border-radius: 4px;
        border-width: 2px;
        border-style: solid;
        border-color: #11111b;
      }
      
      #workspaces button {
        padding: 5px;
        color: #363646;
        margin-right: 5px;
      }
      
      #workspaces button.active {
        color: #7e9cd8;
      }
      
      #workspaces button.focused {
        color: #7e9cd8;
        background: #eba0ac;
        border-radius: 4px;
      }
      
      #workspaces button.urgent {
        color: #16161d;
        background: #a6e3a1;
        border-radius: 4px;
      }
      
      #workspaces button:hover {
        background: transparent;
        color: #957fb8;
        /* border-radius: 4px; */
      }
      
      #backlight,
      #battery,
      #clock,
      #cpu,
      #custom-language,
      #custom-updates,
      #custom-caffeine,
      #custom-weather,
      #custom-vpn,
      #idle_inhibitor,
      #memory,
      #network,
      #pulseaudio,
      #pulseaudio.microphone,
      #temperature,
      #tray,
      #window,
      #workspaces {
        background: #1f1f28;
        padding: 0px 10px;
        /* margin: 2px 0px; */
        margin-top: 8px;
        border: 1px solid #2a2a37;
        /* border: 1px solid #E46876; */
      }
      
      #tray {
        border-radius: 4px;
        margin-right: 4px;
      }
      
      #custom-vpn {
        color: #957fb8;
        border-radius: 4px;
        margin-left: 8px;
      }
      
      #custom-vpn.connected {
        color: #1f1f28;
        background: #98bb6c;
      }
      
      #custom-vpn.disconnected {
        color: #e46876;
      }
      
      #idle_inhibitor {
        color: #957fb8;
        border-radius: 4px;
        margin-left: 8px;
	padding-right: 14px;
      }
      
      #idle_inhibitor.activated {
        color: #1f1f28;
        background: #957fb9;
      }
      
      #workspaces {
        background: #1f1f28;
        border-radius: 4px;
        margin-left: 8px;
        padding-right: 0px;
        padding-left: 5px;
      }
      
      #custom-caffeine {
        color: #89dceb;
        border-radius: 4px 0px 0px 4px;
        border-right: 0px;
        margin-left: 10px;
      }
      
      #backlight {
        color: #dca561;
        border-right: 0px;
        border-radius: 4px 0 0 4px;
      }
      
      #custom-language {
        color: #f38ba8;
        border-left: 0px;
        border-right: 0px;
      }
      
      #custom-updates {
        color: #957fb8;
        border-radius: 4px 0 0 4px;
        /* border-left: 0px; */
        border-right: 0px;
      }
      
      #window {
        border-radius: 4px;
        margin-left: 60px;
        margin-right: 60px;
      }
      
      #clock {
        background: #363646;
        /* border: 1px solid transparent; */
        border-left: 0px;
        color: #7e9cd8;
        border-radius: 0 4px 4px 0;
        margin-right: 8px;
      }
      
      #network {
        color: #f9e2af;
        border-left: 0px;
        border-right: 0px;
      }
      
      #pulseaudio {
        color: #7e9cd8;
        border-left: 0px;
        border-right: 0px;
      }
      
      #pulseaudio.microphone {
        color: #d27e99;
        border-radius: 0 4px 4px 0;
        border-left: 0px;
        margin-right: 10px;
      }
      
      #battery {
        color: #98bb6c;
        /* border-radius: 0 4px 4px 0; */
        /* margin-right: 10px; */
        border-left: 0px;
        border-right: 0px;
      }
      
      #custom-weather {
        border-radius: 0px 10px 10px 0px;
        border-right: 0px;
        margin-left: 0px;
      }
      
      #cpu {
        color: #7fb4ca;
        border-right: 0px;
        border-radius: 4px 0 0 4px;
      }
      
      #memory {
        color: #ffa066;
        border-left: 0px;
        border-radius: 0 4px 4px 0;
        margin-right: 10px;
      }
      
      #temperature {
        border-left: 0px;
        /* border-right: 0px; */
        border-radius: 0 4px 4px 0;
        margin-right: 10px;
      }
      
      #temperature.critical {
        color: #e46876;
      }
      
      #network {
        font-size: 14px;
        color: #957fb8;
        border-right: 0px;
        border-radius: 4px 0 0 4px;
      }
    '';
  };

  home.file.".config/gtklock/style.css".text = ''
    window {
      background-image: url("../../.wallpaper.png");
      background-size: auto 100%;
      background-position: center;
    }

    #clock-label {
      font-size: 0;
      opacity: 0;
    }

    #input-label {
      font-size: 0;
      opacity: 0;
    }

    #unlock-button {
      opacity: 0;
    }
  '';

  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      font = font + ":size=13";
      terminal = "${pkgs.foot}/bin/foot";
    };
    colors = {
      #background = config.lib.stylix.colors.base00 + "e6";
      #text = config.lib.stylix.colors.base07 + "ff";
      #match = config.lib.stylix.colors.base05 + "ff";
      #selection = config.lib.stylix.colors.base08 + "ff";
      #selection-text = config.lib.stylix.colors.base00 + "ff";
      #selection-match = config.lib.stylix.colors.base05 + "ff";
      #border = config.lib.stylix.colors.base08 + "ff";
    };
    border = {
      width = 3;
      radius = 7;
    };
  };

  services.fnott.enable = true;

}
