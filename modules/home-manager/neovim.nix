{
  config,
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.system;
in {
  programs.neovim = inputs.wlvs-nvim.lib.mkHomeManager {inherit system;};
}
