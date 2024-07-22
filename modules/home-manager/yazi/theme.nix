{ config, pkgs, ... }:

{
  home.file.".config/yazi/themes/kanagawa.tmTheme".source = ../../../themes/kanagawa/kanagawa.tmTheme;

  programs.yazi.theme = {
    manager = {
      syntect_theme = "$HOME/.config/yazi/themes/kanagawa.tmTheme";
    };
  };
}

