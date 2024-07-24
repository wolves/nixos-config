{

  description = "WLVS - NixOS Flake and Home Manager Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    hypr-contrib.url = "github:hyprwm/contrib";

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wlvs-nvim.url = "github:wolves/wlvs.nvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    hypr-contrib,
    firefox-addons,
    ...
  } @ inputs:
  let
    inherit (self) outputs;

    # ---- SYSTEM SETTINGS ---- #
    system = "x86_64-linux"; # system architecture
    hostname = "fwrk";
    # profile = "personal"; # select profile from profiles directory
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
    browser = "brave"; # select browser from ./user/app/browser/
    editor = "nvim";
    term = "foot"; # default terminal command
    termType = "xterm-256color";
    font = "Intel One Mono"; # select default font
    fontPkg = pkgs.intel-one-mono; # Font package

    pkgs = nixpkgs.legacyPackages.${system};

    # configure lib
    lib = nixpkgs.lib;
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      system = lib.nixosSystem {
        inherit system;

        modules = [
          ./nixos/configuration.nix
          ./nixos/hosts/nixos

          nixos-hardware.nixosModules.framework-11th-gen-intel
        ];

        specialArgs = {
          inherit outputs;
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

        modules = [
          ./home-manager/home.nix
          inputs.anyrun.homeManagerModules.default
        ];

        extraSpecialArgs = {
          inherit inputs;
          inherit outputs;
          inherit system;
          inherit username;
          inherit name;
          inherit hostname;
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
          inherit termType;
          inherit (inputs) hypr-contrib;
          inherit (inputs) anyrun;
          inherit (inputs) firefox-addons;
        };
      };
    };
  };

}
