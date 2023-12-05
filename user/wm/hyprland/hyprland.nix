{ config, lib, pkgs, stdenv, toString, browser, term, font, ... }:

{
  home.packages = with pkgs; [
    alacritty
    feh
    killall
    polkit_gnome
    swaybg
    wev
    fnott
    fuzzel
  ];

  home.file.".wallpaper.png".source = ../../../themes/mtn_wallpaper.png;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = { };
    extraConfig = ''
      exec-once = swaybg -m fill -i $HOME/.wallpaper.png

      general {
	layout = dwindle
	border_size = 2
	gaps_in = 4
	gaps_out = 8
      }

      decoration {
	rounding = 4
      }

      $mod = SUPER

      bind = $mod, D, exec, fuzzel
      bind = $mod, Q, killactive

      input {
        kb_layout = us
	kb_options = ctrl:nocaps
	repeat_delay = 250
	repeat_rate = 50
	follow_mouse = 2
	accel_profile = adaptive
      }

      xwayland {
	force_zero_scaling = true
      }
    '';
    xwayland = { enable = true; };
    systemd = { enable = true; };
  };


  programs.fuzzel.enable = true;

  services.fnott.enable = true;
}
