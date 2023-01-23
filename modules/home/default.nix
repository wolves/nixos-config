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
    ./neovim
    ./hyprland
    ./mako
    ./swaylock
    ./swayidle
    ./syncthing.nix
    inputs.hyprland.homeManagerModules.default
  ];
}

