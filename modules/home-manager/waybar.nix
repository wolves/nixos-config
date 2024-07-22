{ config, pkgs, ... }:

{
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
          "format"= "   {}%";
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
          "format-icons" = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          "format-wifi" = "{icon}   {signalStrength}%";
          "format-ethernet" = "Connected <span font='14'>󰈁</span>";
          "tooltip-format" = "{essid} ({signalStrength}%)\n{ifname} via {gwaddr}/{cidr}";
          "format-linked" = "{ifname} (No IP) <span font='14'>󰈁</span>";
          "format-disconnected" = "󰤮";
          "format-alt" = "{ipaddr}";
          "on-click" = "${pkgs.foot}/bin/footclient nmtui";
	      };

	      "battery" = {
          "states" = {
            "good" = 95;
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon}  {capacity}%";
          "format-charging"= "󰂄 {capacity}%";
          "format-plugged"= "󱘖 {capacity}%";
          "format-alt" = "{time} {icon}";
          "format-icons" = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
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
}

