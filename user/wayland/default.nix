{ config, pkgs, hypr-contrib, wm, font, ... }:

{
  imports = [
    (./. + "../../../user/wayland/wm"+("/"+wm))
    ./waybar
    ../app/terminal/foot.nix
  ];

  home.packages = with pkgs; [
    foot
    feh
    killall
    polkit_gnome
    swaybg
    swayidle
    wl-clipboard
    hyprland-protocols
    gtklock
    swaylock-effects
    wev
    fnott
    fuzzel
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
  ];

  home.file.".wallpaper.png".source = ../../themes/aenami_escape.jpg;

  home.file.".config/swaylock/config".text = ''
    daemonize
    image="$HOME/.wallpaper.png"
    show-failed-attempts
    clock
    effect-blur=5x5
    color=1f1d2e80
    font="Product Sans"
    indicator
    indicator-radius=200
    indicator-thickness=20
    line-color=1f1d2e
    ring-color=191724
    inside-color=1f1d2e
    key-hl-color=eb6f92
    separator-color=00000000
    text-color=e0def4
    text-caps-lock-color=""
    line-ver-color=eb6f92
    ring-ver-color=eb6f92
    inside-ver-color=1f1d2e
    text-ver-color=e0def4
    ring-wrong-color=31748f
    text-wrong-color=31748f
    inside-wrong-color=1f1d2e
    inside-clear-color=1f1d2e
    text-clear-color=e0def4
    ring-clear-color=9ccfd8
    line-clear-color=1f1d2e
    line-wrong-color=1f1d2e
    bs-hl-color=31748f
    grace=0
    grace-no-mouse
    grace-no-touch
    datestr=%m.%d
    fade-in="0.1"
    ignore-empty-password
  '';

  home.file.".config/gtklock/style.css".text = ''
    window {
      background-image: url("../../.wallpaper.png");
      background-size: auto 100%;
      background-position: center;
    }

    #clock-label {
      font-size: 0;
      opacity: 0;
    }

    #input-label {
      font-size: 0;
      opacity: 0;
    }

    #unlock-button {
      opacity: 0;
    }
  '';

  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      font = font + ":size=13";
      terminal = "${pkgs.foot}/bin/foot";
    };
    colors = {
      #background = config.lib.stylix.colors.base00 + "e6";
      #text = config.lib.stylix.colors.base07 + "ff";
      #match = config.lib.stylix.colors.base05 + "ff";
      #selection = config.lib.stylix.colors.base08 + "ff";
      #selection-text = config.lib.stylix.colors.base00 + "ff";
      #selection-match = config.lib.stylix.colors.base05 + "ff";
      #border = config.lib.stylix.colors.base08 + "ff";
    };
    border = {
      width = 3;
      radius = 7;
    };
  };

  services.fnott.enable = true;
}
