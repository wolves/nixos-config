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
      luks.devices."luks-b8d57d33-51d0-4b28-859b-04d3c3c1ab15".device = "/dev/disk/by-uuid/b8d57d33-51d0-4b28-859b-04d3c3c1ab15";
      luks.devices."luks-b8d57d33-51d0-4b28-859b-04d3c3c1ab15".keyFile = "/crypto_keyfile.bin";
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
