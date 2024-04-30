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
    package = pkgs.neovim-nightly;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      popup-nvim
      
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip

      luasnip
      friendly-snippets

      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      rainbow-delimiters-nvim
      nvim-ts-context-commentstring

      rust-tools-nvim

      telescope-nvim
      telescope-fzf-native-nvim

      kanagawa-nvim

      better-escape-nvim
      which-key-nvim
      neoscroll-nvim
      neogit
      gitsigns-nvim
      diffview-nvim
      fzf-lua

      toggleterm-nvim

      mini-nvim
      trouble-nvim
      todo-comments-nvim

      treesj

      dressing-nvim
      # bufferline-nvim
      barbar-nvim
      lualine-nvim
      nvim-navic
      indent-blankline-nvim
      nvim-notify
      noice-nvim
      nvim-colorizer-lua
      nui-nvim
      nvim-web-devicons


      # Add custom config from overlay
      wlvs-nvim
    ];

    extraLuaConfig = ''
      require 'wlvs'.init()
    '';

    extraPackages = with pkgs; [
      lua-language-server

      # Nix LSP
      nil

      nodePackages."bash-language-server"
      nodePackages."dockerfile-language-server-nodejs"
      nodePackages."pyright"
      nodePackages."typescript"
      nodePackages."typescript-language-server"
      nodePackages."vscode-langservers-extracted"
      nodePackages."yaml-language-server"

      gopls
      gofumpt
      golines
      gotools

      rust-analyzer

      wl-clipboard
      yarn
    ];

  };
}
