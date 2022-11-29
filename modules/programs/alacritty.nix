{ pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = rec {
          #normal.family = "JetBrains Mono";
          #normal.family = "Source Code Pro";
          normal.family = "Iosevka";
          bold = { style = "Medium"; };
        };
        padding = {
          x = 6;
          y = 6;
        };
        offset = {
          x = -1;
          y = 0;
        };
      };
    };
  };
}
