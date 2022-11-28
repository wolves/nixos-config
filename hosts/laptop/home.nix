{ pkgs, ... }:

{
  imports = 
    [
      ../../modules/desktop/hyprland/home.nix
    ];

  home = {
    packages = with pkgs; [
      acpi
    ];
  };

  programs = {
    alacritty.settings.font.size = 11;
  };
}
