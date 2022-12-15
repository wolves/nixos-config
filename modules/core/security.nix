{
  config,
  pkgs,
  ...
}: {
  security = {
    sudo.wheelNeedsPassword = false;

    # allow wayland lockers to unlock the screen
    pam.services.swaylock.text = "auth include login";

    rtkit.enable = true;
  };
}
