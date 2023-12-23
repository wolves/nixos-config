{ config, pkgs, ... }:

{
  programs.go = {
    enable = true;
    goPath = "code/go";
  };
}
