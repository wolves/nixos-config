{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./system.nix
    # ./schizo.nix
    ./security.nix
    ./network.nix
    ./nix.nix
    ./users.nix
    ./openssh.nix
    ./blocker.nix
  ];
}
