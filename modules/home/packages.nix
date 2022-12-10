{
  inputs,
  pkgs,
  config,
  ...
}: let
  # mpv-unwrapped = pkgs.mpv-unwrapped.overrideAttrs (o: {
  #   src = pkgs.fetchFromGitHub {
  #     owner = "mpv-player";
  #     repo = "mpv";
  #     rev = "48ad2278c7a1fc2a9f5520371188911ef044b32c";
  #     sha256 = "sha256-6qbv34ysNQbI/zff6rAnVW4z6yfm2t/XL/PF7D/tjv4=";
  #   };
  # });
in {
  home = {
    packages = with pkgs; [
      # Terminal
      acpi      # Battery
      bat       # Better cat
      direnv
      duf       # Disk Usage
      exa       # Better ls
      fd        # Better find
      zoxide    # Better cd
      ripgrep   # Better grep
      fzf       # Fuzzy Finder
      pfetch    # Minimal Fetch
      ranger    # File Mgr
      tealdeer    # man synopsis
      tree-sitter
      gh        # Github CLI
      gum
      killall
      tailscale

      # A/V
      feh       # Image Viewer
      mpv       # Media Player

      # Apps
      calibre
      firefox

      # File Mgmt
      okular    # PDF Viewer
      pcmanfm   # File Mgr
      rsync     # Syncer
      unzip     # Zip Files
      unrar     # Rar Files

      lua
      rust-analyzer
      dconf
      gcc
    ];
    pointerCursor = {
      #name = "Dracula-cursors";
      #package = pkgs.dracula-theme;
      #name = "Catppuccin-Mocha-Dark-Cursors";
      #package = pkgs.catppuccin-cursors.mochaDark;
      #name = "Phinger-cursors";
      #package = pkgs.phinger-cursors;
      #gtk.enable = true;
      name = "phinger-cursors";
      package = pkgs.phinger-cursors;
      size = 48;
    };
  };
}
