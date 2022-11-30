{ inputs, lib, config, pkgs, ... }:

{
  # packages
  home.packages = with pkgs; [
    eww-wayland
    pamixer
    brightnessctl
  ];
}
