{

  description = "First Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay, firefox-addons, ... }@inputs:
  let
    # ---- SYSTEM SETTINGS ---- #
    system = "x86_64-linux"; # system architecture
    hostname = "fwrk";
    profile = "personal"; # select profile from profiles directory
    timezone = "America/New_York";
    locale = "en_US.UTF-8";

	  # ----- USER SETTINGS ----- #
    username = "wlvs";
    name = "wlvs";
    email = "cstingl@protonmail.com";
    dotfilesDir = "~/.dots";
    theme = "kanagawa"; # select theme from themes dir (./themes/)
    wm = "hyprland"; # select window manager; must exist in both ./user/wm/ & ./system/wm/
    wmType = "wayland"; # x11 or wayland
    browser = "firefox"; # select browser from ./user/app/browser/
    editor = "nvim";
    term = "foot"; # default terminal command
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
          inherit system;
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
          inherit (inputs) firefox-addons;
          inherit (inputs) neovim-nightly-overlay;
        };
      };
    };
  };

}
