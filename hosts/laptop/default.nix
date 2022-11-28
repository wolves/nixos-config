{ config, pkgs, user, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;

      efi ={
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      #grub = {                              # Most of grub is set up for dual boot
      #  enable = true;
      #  version = 2;
      #  devices = [ "nodev" ];
      #  efiSupport = true;
      #  useOSProber = true;                 # Find all boot options
      #  configurationLimit = 2;
      #};
      #timeout = 1;
    };

    initrd = {
      # Setup keyfile
      secrets = {
	"/crypto_keyfile.bin" = null;
      };

      # Enable swap on luks
      luks.devices."luks-b3b1b94f-d034-4672-b8ab-51c914735bab".device = "/dev/disk/by-uuid/b3b1b94f-d034-4672-b8ab-51c914735bab";
      luks.devices."luks-b3b1b94f-d034-4672-b8ab-51c914735bab".keyFile = "/crypto_keyfile.bin";
    };
  };

  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  services = {
    # tlp.enable = true;
    auto-cpufreq.enable = true;
    blueman.enable = true;
  };

  # ---

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    xkbOptions = "ctrl:nocaps";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}
