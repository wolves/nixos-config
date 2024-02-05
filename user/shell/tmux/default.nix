{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      pain-control
    ];
  };
}
