#
# Neovim
#
{ inputs, pkgs, ... }:
let neovim-overlay = inputs.neovim-nightly-overlay.packages.${pkgs.system};
in
{
  programs.neovim = {
    enable = true;
    package = neovim-overlay.neovim;

    viAlias = true;
    vimAlias = true;
  };
}
