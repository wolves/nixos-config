{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  username,
  editor,
  termType,
  browser,
  hypr-contrib,
  ...
}: {
  imports = with outputs.homeManagerModules; [
    # alacritty
    anyrun
    bat
    brave
    direnv
    # firefox
    fish
    # flatpak
    foot
    git
    hyprland
    mime
    mpv
    neovim
    nu
    ripgrep
    starship
    tmux
    virtualization
    waybar
    wlogout
    yazi
    zathura
    zoxide
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = ["electron-19.1.9"];
    };
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  home.packages = with pkgs; [
    gh
    vlc
    syncthing
    gnumake
    just

    obs-studio
    ffmpeg
    calibre

    feh
    killall
    libnotify
    polkit_gnome
    swww
    swayidle
    wl-clipboard
    hyprland-protocols
    wev
    fnott
    grim
    slurp
    hypr-contrib.packages.${pkgs.system}.grimblast
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    pamixer

    eza
    fd
    bottom
    tealdeer
    duf
    fzf
    rsync
    unzip
    brightnessctl

    figma-linux

    (pkgs.writeShellScriptBin "dvd" ''
      #!/bin/sh
      echo "use flake \"github:the-nix-way/dev-templates?dir=$1\"" >> .envrc
      direnv allow
    '')
  ];

  services = {
    fnott.enable = true;
    blueman-applet.enable = true;
    # network-manager-applet.enable = true;
    syncthing.enable = true;
  };

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dots";
      XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
      XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
      XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
      XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
    };
  };
  xdg.mime.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".cache/wallpaper.png".source = ../themes/aenami_escape.jpg;
    ".cache/avatar.png".source = ../themes/avatars/guy_fawkes.png;
  };

  home.sessionVariables = {
    EDITOR = editor;
    TERM = termType;
    BROWSER = browser;
  };

  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "lavender";
      };
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
