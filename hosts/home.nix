{ config, lib, pkgs, user, ... }:

{
  imports =
    (import ../modules/editors) ++
    (import ../modules/programs);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      bat       # Better cat
      exa       # Better ls
      zoxide    # Better cd
      ripgrep   # Better grep
      fzf       # Fuzzy Finder
      pfetch    # Minimal Fetch
      ranger    # File Mgr
      tldr      # man synopsis
      gh        # Github CLI

      # A/V
      feh       # Image Viewer
      mpv       # Media Player

      # Apps
      firefox
      google-chrome

      # File Mgmt
      okular    # PDF Viewer
      pcmanfm   # File Mgr
      rsync     # Syncer
      unzip     # Zip Files
      unrar     # Rar Files

      lua
    ];

    pointerCursor = {
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrains Mono Medium";
    };
  };
}
