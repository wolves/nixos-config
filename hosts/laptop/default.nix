{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(../../modules/desktop/gnome/default.nix)];

  #imports =
  #  [(import ./hardware-configuration.nix)];

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
