#
# Neovim
#

{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
	# Syntax
	vim-nix

	# Customization
	srcery-vim
      ];

      extraConfig = ''
	syntax enable
	colorscheme srcery
	
	highlight Comment cterm=italic gui=italic
	
        set number
        set relativenumber
      '';
    };
  };
}
