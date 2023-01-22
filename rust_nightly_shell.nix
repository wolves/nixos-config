{ pkgs ? import <nixpkgs> {} }:
let
  rust-overlay = import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz");
  pkgs = import <nixpkgs> { overlays = [ rust-overlay ]; };
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      hello
      rust-bin.nightly.latest.default
    ];
  }
