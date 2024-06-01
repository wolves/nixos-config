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

      background = [
        {
          monitor = "";
          path = "$HOME/.wallpaper.png";

          blur_passes = 3; # 0 disables blurring
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
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
          position = "0, -30";
          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
