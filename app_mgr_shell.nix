{ pkgs ? import <nixpkgs> {} }:
let
  node12-pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/d1c3fea7ecbed758168787fe4e4a3157e52bc808.tar.gz";
  }) {};
  nodejs-12_22_11 = node12-pkgs.nodejs-12_x;

  yarnjs-1_22_19-pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/ee01de29d2f58d56b1be4ae24c24bd91c5380cea.tar.gz";
  }) {};
  yarnjs-1_22_19 = yarnjs-1_22_19-pkgs.yarn;

  startapp = pkgs.writeScriptBin "startapp" ''
    yarn run start
  '';

  nodejs-current = nodejs-12_22_11;
  yarnjs-current = yarnjs-1_22_19;

in pkgs.mkShell {
  name = "Appliance Manager Shell";

  buildInputs = [
    startapp

    nodejs-current
    yarnjs-current

    # keep this line if you use bash
    #pkgs.bashInteractive
  ];

  shellHook = ''
    echo "Welcome to the Appliance Manager Shell"
  '';
}
