{
  config,
  pkgs,
  ...
}: {
  security = {
    sudo.wheelNeedsPassword = false;

    pam.services = {
      login.enableGnomeKeyring = true;
      # allow wayland lockers to unlock the screen
      swaylock.text = "auth include login";
    };

    rtkit.enable = true;
  };
}
