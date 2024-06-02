{ config, pkgs, hypr-contrib, wm, font, ... }:

{
  imports = [
    (./. + "../../../user/wayland/wm"+("/"+wm))
    ./hyprlock.nix
    ./hypridle.nix
    ./anyrun
    ./waybar
    ../app/terminal/foot.nix
  ];

  home.packages = with pkgs; [
    foot
    feh
    killall
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
  ];

  home.file.".wallpaper.png".source = ../../themes/aenami_escape.jpg;

  services.fnott.enable = true;
}
