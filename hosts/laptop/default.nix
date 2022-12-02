{ config, pkgs, user, ... }:

{
  # imports =
  #   # [(import ./hardware-configuration.nix)] ++
  #   [(../../modules/desktop/hyprland/default.nix)];

  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  services = {
    # tlp.enable = true;
    auto-cpufreq.enable = true;
    blueman.enable = true;

    xserver = {
      enable = true;

      layout = "us";
      xkbOptions = "ctrl:nocaps";
      libinput.enable = true;

      displayManager = {
        gdm = {
          enable = true;
        };
      };

      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };

}
