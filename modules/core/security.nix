{
  config,
  pkgs,
  ...
}: {
  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
  };
}
