{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  username,
  name,
  ...
}: {
  users.defaultUserShell = pkgs.fish;
  users.users = {
    ${username} = {
      isNormalUser = true;
      description = name;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      packages = with pkgs; [];
      uid = 1000;
    };
  };
}
