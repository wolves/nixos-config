{ config, pkgs, ... }:

{
  imports = [
    ./tmux
  ];
  
  home.packages = with pkgs; [
    killall
    libnotify
    bat eza fd bottom ripgrep
    tealdeer
    duf
    zoxide
    fzf
    rsync
    unzip
    brightnessctl
  ];
}
