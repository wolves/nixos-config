{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    killall
    libnotify
    bat eza fd bottom ripgrep
    fzf
    rsync
    tmux
    unzip
    brightnessctl
  ];
}
