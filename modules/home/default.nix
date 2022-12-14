{
    inputs,
    pkgs,
    config,
    lib,
    self,
    ...
}:
# glue configs together
{
  config.home.stateVersion = "22.11";
  imports = [
    ./packages.nix

    ./files
    ./foot
    ./alacritty
    ./rofi
    ./wofi
    ./shell
    ./eww
    ./hyprland
    ./mako
    ./swaylock
    inputs.hyprland.homeManagerModules.default
  ];
}

