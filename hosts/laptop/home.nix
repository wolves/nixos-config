{ pkgs, ... }:

{
  imports = 
    [
      ../../modules/desktop/hyprland/home.nix
    ];

  home = {
    package = with pkgs; [

    ];
  };

  programs = {
    alacritty.settings.font.size = 11;
  };
}
