{

    description = "First Flake";

    inputs = {
      nixpkgs.url = "nixpkgs/nixos-unstable";
      home-manager.url = "github:nix-community/home-manager/master";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }:
      let
	# ---- SYSTEM SETTINGS ---- #
	system = "x86_64-linux"; # system architecture
	hostname = "fwrk";
	profile = "personal"; # select profile from profiles directory
	timezone = "America/New_York";
	locale = "en_US.UTF-8";

	# ----- USER SETTINGS ----- #
	username = "wlvs";
	name = "Christopher";
	email = "cstingl@pm.me";
	dotfilesDir = "~/.dots";
	theme = "kanagawa"; # select theme from themes dir (./themes/)
	wm = "hyprland"; # select window manager; must exist in both ./user/wm/ & ./system/wm/
	wmType = "wayland"; # x11 or wayland
	browser = "brave"; # select browser from ./user/app/browser/
	editor = "nvim";
	term = "alacritty"; # default terminal command
	font = "Intel One Mono"; # select default font
	fontPkg = pkgs.intel-one-mono; # Font package

	pkgs = nixpkgs.legacyPackages.${system};

	# configure lib
	lib = nixpkgs.lib;
      in {
	nixosConfigurations = {
	  system = lib.nixosSystem {
	    inherit system;
	    modules = [ (./. + "/profiles"+("/"+profile)+"/configuration.nix") ]; # load configuration from selected PROFILE
	    specialArgs = {
	      inherit username;
	      inherit name;
	      inherit hostname;
	      inherit timezone;
	      inherit locale;
	      inherit theme;
	      inherit font;
	      inherit fontPkg;
	      inherit wm;
	    };
	  };
	};
        homeConfigurations = {
	  user = home-manager.lib.homeManagerConfiguration {
	    inherit pkgs;
	    modules = [ (./. + "/profiles"+("/"+profile)+"/home.nix") ]; # load home.nix from selected PROFILE
	    extraSpecialArgs = {
	      inherit username;
	      inherit name;
	      inherit hostname;
	      inherit profile;
	      inherit email;
	      inherit dotfilesDir;
	      inherit theme;
	      inherit font;
	      inherit fontPkg;
	      inherit wm;
	      inherit wmType;
	      inherit browser;
	      inherit editor;
	      inherit term;
	    };
	  };
	};
      };

}
