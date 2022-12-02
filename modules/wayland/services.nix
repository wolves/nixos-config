{
  config,
  pkgs,
  ...
}: {
  hardware.pulseaudio.enable = false;

  services = {

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
