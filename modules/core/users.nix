{
  config,
  pkgs,
  ...
}: {
  users.users.wlvs = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
}
