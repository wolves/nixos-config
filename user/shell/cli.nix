{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    killall
    libnotify
    bat eza fd bottom ripgrep
    duf
    fzf
    rsync
    tmux
    unzip
    brightnessctl
  ];
}
