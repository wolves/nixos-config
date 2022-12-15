{
  config,
  pkgs,
  ...
}: {
  users.users.wlvs = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "power"
      "nix"
    ];
    uid = 1000;
    shell = pkgs.fish;
  };
}
