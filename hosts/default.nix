{
    nixpkgs,
    self,
    ...
}: let
  inputs = self.inputs;
  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  wayland = ../modules/wayland;
  hw = inputs.nixos-hardware.nixosModules;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [core];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.wlvs = ../modules/home;
    # users.wlvs = {
    #   imports = [(./home.nix)] ++ [(import ./laptop/home.nix)];
    # };
  };
  # pkgs = import nixpkgs {
  #   inherit system;
  #   config.allowUnfree = true;
  # };
  #
  # lib = nixpkgs.lib;
in {
  laptop = nixpkgs.lib.nixosSystem {
    # inherit system;
    system = "x86_64-linux";
    # specialArgs = { inherit inputs user location hyprland; };
    modules = [
      {networking.hostName = "fwrk";}
      ./laptop/hardware-configuration.nix

      ./laptop
      bootloader
      # hw.framework
      wayland
      hmModule
      {inherit home-manager;}

      # inputs.hyprland.nixosModules.default
    ] ++
    shared;

      # home-manager.nixosModules.home-manager {
      #   home-manager = {
      #     useGlobalPkgs = true;
      #     useUserPackages = true;
      #     extraSpecialArgs = { inherit inputs user; };
      #     users.${user} = {
      #       imports = [(./home.nix)] ++ [(import ./laptop/home.nix)];
      #     };
      #   };
      # }
    # ] ++
    # shared;

    specialArgs = { inherit inputs; };
  };
}
