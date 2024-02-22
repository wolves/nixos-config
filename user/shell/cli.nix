{ config, pkgs, ... }:

{
  imports = [
    ./tmux
  ];
  
  home.packages = with pkgs; [
    killall
    libnotify
    eza fd bottom ripgrep
    tealdeer
    duf
    zoxide
    fzf
    rsync
    unzip
    brightnessctl
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "base16-256";
    };
  };
}
