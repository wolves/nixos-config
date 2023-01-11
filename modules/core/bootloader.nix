{
  config,
  pkgs,
  lib,
  ...
}: {
  boot = {
    cleanTmpDir = true;
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode="auto";
        configurationLimit = 6;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 5;
    };

    initrd = {
      # Setup keyfile
      secrets = {
        "/crypto_keyfile.bin" = null;
      };

      # Enable swap on luks
      luks.devices."luks-68906de8-ef94-4bbe-b46b-9746c934757a".device = "/dev/disk/by-uuid/68906de8-ef94-4bbe-b46b-9746c934757a";
      luks.devices."luks-68906de8-ef94-4bbe-b46b-9746c934757a".keyFile = "/crypto_keyfile.bin";
    };

    kernelParams = [
      "quiet"
      "splash"
      "udev.log_level=3"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };
}
