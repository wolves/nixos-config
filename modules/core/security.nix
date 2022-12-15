{
  config,
  pkgs,
  ...
}: {
  security = {
    rtkit.enable = true;

    pam.services = {
      login.enableGnomeKeyring = true;
      # allow wayland lockers to unlock the screen
      swaylock.text = "auth include login";
    };
    # sudo.wheelNeedsPassword = false;
    doas = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          persist = true;
          keepEnv = false;
        }
        {
          groups = ["power"];
          noPass = true;
          cmd = "${pkgs.systemd}/bin/poweroff";
        }
        {
          groups = ["power"];
          noPass = true;
          cmd = "${pkgs.systemd}/bin/reboot";
        }
        {
          groups = ["nix"];
          cmd = "nix-collect-garbage";
          noPass = true;
        }
        {
          groups = ["nix"];
          cmd = "nixos-rebuild";
          keepEnv = true;
        }
      ];
    };
    sudo.enable = false;
  };
}
