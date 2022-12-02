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
  config.home.stateVersion = "22.05";
  imports = [
    ./packages.nix

    ./alacritty
    ./rofi
    ./shell
    ./eww
    ./hyprland
    ./nvim
    inputs.hyprland.homeManagerModules.default
  ];
  # config.modules = {
  #   programs = {
  #     alacritty.settings.font.size = 12;
  #   };
  # };
}

