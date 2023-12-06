{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    killall
    libnotify
    bat eza fd bottom ripgrep
    duf
    zoxide
    fzf
    rsync
    tmux
    unzip
    brightnessctl
  ];
}
