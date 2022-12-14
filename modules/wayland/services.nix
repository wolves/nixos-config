{
  config,
  pkgs,
  ...
}:
let
  # user = "wlvs";
  # greetd = "${pkgs.greetd.greetd}/bin/greetd";
  # gtkgreet = "${pkgs.greetd.gtkgreet}/bin/gtkgreet";
  #
  # sway-kiosk = command: "${pkgs.sway}/bin/sway --config ${pkgs.writeText "kiosk.config" ''
  #   output * bg #000000 solid_color
  #   exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
  #   exec "${command}; ${pkgs.sway}/bin/swaymsg exit"
  # ''}";
in {
  hardware.pulseaudio.enable = false;
  # systemd.services = {
  #   seatd = {
  #     enable = true;
  #     description = "Seat management daemon";
  #     script = "${pkgs.seatd}/bin/seatd -g wheel";
  #     serviceConfig = {
  #       Type = "simple";
  #       Restart = "always";
  #       RestartSec = "1";
  #     };
  #     wantedBy = ["multi-user.target"];
  #   };
  # };
  #
  services = {
    greetd ={
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "wlvs";
        };
        default_session = initial_session;
      };
    };

    gnome.gnome-keyring.enable = true;

    auto-cpufreq.enable = true;
    blueman.enable = true;
    lorri.enable = true;
    flatpak.enable = true;
    printing.enable = true;
    fstrim.enable = true;

    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
