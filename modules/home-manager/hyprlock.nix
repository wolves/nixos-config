{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      image = [
        {
          monitor = "";
          path = "$HOME/.cache/avatar.png";
          size = 280;
          rounding = -1; # negative values mean circle
          border_size = 4;
          border_color = "rgb(363646)";
          rotate = 0; # degrees, counter-clockwise
          reload_time = -1; # seconds between reloading, 0 to reload with SIGUSR2
          position = "0, 90";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          size = "400, 40";
          outline_thickness = 3;
          dots_center = true;
          dots_size = 0.33;
          dots_spacing = 0.15;
          inner_color = "rgb(ffffff)";
          outer_color = "rgb(363646)";
          font_color = "rgb(363646)";
          placeholder_text = "<i>Password...</i>";
          hide_input = false;
          rounding = 6;
          position = "0, -160";
          valign = "center";
          halign = "center";
        }
      ];

      background = [
        {
          monitor = "";
          path = "$HOME/.cache/wallpaper.png";

          blur_passes = 3; # 0 disables blurring
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        { 
          monitor = "";
          text = "$TIME";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 55;
          font_family = "Product Sans";
          position = "-90, 30";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];

    };
  };
}

