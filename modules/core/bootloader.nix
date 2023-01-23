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

    kernelParams = [
      "quiet"
      "splash"
      "udev.log_level=3"
    ];
    #consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth.enable = true;
  };
}
