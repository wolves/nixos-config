{ config, pkgs, ... }:

{
  imports =[
    ./keymap.nix
    ./theme.nix
  ];

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "modified";
        sort_dir_first = true;
        sort_reverse = true;
      };
    };
  };
}
