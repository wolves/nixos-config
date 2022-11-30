{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #nur = {
    #  url = "github:nix-community/NUR";
    #};

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    hyprland = {
      url = "github:vaxerski/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, ... }:
    let
      user = "wlvs";
      location = "$HOME/.config/nixos";
    in
    {
      nixosConfigurations = (
	import ./hosts {
	  inherit (nixpkgs) lib;
	  inherit inputs nixpkgs home-manager user location hyprland;
	}

	# fwrk = lib.nixosSystem {
	#   inherit system;
	#   modules = [ ./configuration.nix ];
	# };
      );
    };
}
