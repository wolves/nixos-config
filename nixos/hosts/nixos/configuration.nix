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
    lutris
    network
    power
    sshd
    steam
  ];
}
