{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [./fonts.nix ./services.nix];
  # nixpkgs.overlays = with inputs; [nixpkgs-wayland.overlay];
  # environment.etc."greetd/environments".text = ''
  #   Hyprland
  # '';

  environment = {
    systemPackages = with pkgs; [
      (catppuccin-gtk.override {size = "compact";})
      bibata-cursors
      papirus-icon-theme
      greetd.gtkgreet
    ];

    # set gtk theme
    etc."gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-cursor-theme-name=Bibata-Modern-Classic
      gtk-cursor-theme-size=24
      gtk-font-name=Lato
      gtk-icon-theme-name=Papirus-Dark
      gtk-theme-name=Catppuccin-Orange-Dark-Compact
    '';

    etc."greetd/environments".text = ''
      Hyprland
      fish
    '';


    variables = {
      NIXOS_OZONE_WL = "1";
      DISABLE_QT5_COMPAT = "0";
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP="Hyprland";
      XDG_SESSION_DESKTOP="Hyprland";
    };
    # dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
    # loginShellInit = ''
    #   dbus-update-activation-environment --systemd DISPLAY
    #   eval $(gnome-keyring-daemon --start)
    # '';
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
}
