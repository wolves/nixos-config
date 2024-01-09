{ config, pkgs, hypr-contrib, wm, font, ... }:

{
  imports = [
    (./. + "../../../user/wayland/wm"+("/"+wm))
    ./waybar
    ./swaylock.nix
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
