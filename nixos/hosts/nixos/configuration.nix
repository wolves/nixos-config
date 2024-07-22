{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = with outputs.nixosModules; [
    bluetooth
    doas
    fonts
    hyprland
    network
    power
    sshd
  ];
}
