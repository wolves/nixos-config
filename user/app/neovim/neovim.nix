{  config, pkgs, inputs, ... }:

{
  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          wlvs-nvim = prev.vimUtils.buildVimPlugin {
            name = "wlvs-nvim";
            src = ../../../config/nvim;
          };
        };
      })
    ];
  };

  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    luaConfig = file: builtins.readFile file;
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp

      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      popup-nvim

      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-ts-rainbow2

      telescope-nvim
      telescope-fzf-native-nvim

      kanagawa-nvim
      which-key-nvim
      neoscroll-nvim
      neogit
      diffview-nvim
      fzf-lua

      toggleterm-nvim

      mini-nvim
      trouble-nvim
      todo-comments-nvim

      # Add custom config from overlay
      wlvs-nvim

      {
        plugin = better-escape-nvim;
        type = "lua";
        config = ''
          require("better_escape").setup({
            mapping = { "jk", "jj" }, -- a table with mappings to use
            timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
            clear_empty_lines = false, -- clear line after escaping if there is only whitespace
            keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
          })
        '';
      }
    ];

    extraLuaConfig = ''
      require 'wlvs'.init()
    '';
  };
}
