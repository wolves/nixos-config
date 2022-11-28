{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;

      layout = "us";
      xkbOptions = "ctrl:nocaps";
      libinput.enable = true;

      displayManager = {
	gdm = {
	  enable = true;
	};
      };

      desktopManager = {
	gnome = {
	  enable = true;
	};
      };
    };
  };
}
