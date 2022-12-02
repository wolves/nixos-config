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
  };
in {
  laptop = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "fwrk";}
      ./laptop/hardware-configuration.nix
      bootloader
      hw.framework
      wayland
      hmModule
      {inherit home-manager;}
    ]
    ++ shared;
  specialArgs = { inherit inputs; };
  };
}
