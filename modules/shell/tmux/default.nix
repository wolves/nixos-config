{ config, pkgs, ... }:

let
  tmuxConf = builtins.readFile ./default.conf;
in
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    extraConfig = tmuxConf;
    escapeTime = 30;
    keyMode = "vi";
    shortcut = "a";
    terminal = "xterm-256color";
  };
}
