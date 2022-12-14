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
    variables = {
      NIXOS_OZONE_WL = "1";
      # __GL_GSYNC_ALLOWED = "0";
      # __GL_VRR_ALLOWED = "0";
      DISABLE_QT5_COMPAT = "0";
      # GDK_BACKEND = "wayland";
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      #WLR_DRM_NO_ATOMIC = "1";
      # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      # QT_QPA_PLATFORMTHEME = "qt5ct";
      # QT_STYLE_OVERRIDE = "kvantum";
      MOZ_ENABLE_WAYLAND = "1";
      # WLR_BACKEND = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";
      # SDL_VIDEODRIVER = "wayland";
      # CLUTTER_BACKEND = "wayland";
      # GTK_THEME = "Catppuccin-Frappe-Pink";
      # WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP="Hyprland";
      XDG_SESSION_DESKTOP="Hyprland";
    };
    # dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
    loginShellInit = ''
      dbus-update-activation-environment --systemd DISPLAY
      eval $(gnome-keyring-daemon --start)
    '';
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
