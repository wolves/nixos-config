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
  home.packages = with pkgs; [
    # Terminal
    acpi      # Battery
    bat       # Better cat
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
    firefox
    google-chrome

    # File Mgmt
    okular    # PDF Viewer
    pcmanfm   # File Mgr
    rsync     # Syncer
    unzip     # Zip Files
    unrar     # Rar Files

    lua
    rust-analyzer
    #zig
    dconf
    gcc
  ];
}
