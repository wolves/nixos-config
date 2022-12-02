{ config, pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
        shell.program = "${pkgs.tmux}/bin/tmux";
        font = rec {
          #normal.family = "JetBrains Mono";
          #normal.family = "Source Code Pro";
          normal.family = "Iosevka";
          bold = { style = "Medium"; };
        };
        font.size = 12;
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
