{
  config,
  pkgs,
  ...
}: let
  repoPath = "${config.home.homeDirectory}/.dots";
in {
  home.sessionVariables = {
    LAZY_NVIM_LOCK_PATH = "${repoPath}/config/nvim/";
  };

  home.file = {
    ".config/nvim" = {
      source = ../../config/nvim;
      recursive = true;
    };
  };

  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    withRuby = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      lua-language-server
      vscode-langservers-extracted
      tree-sitter
      zig

      # Nix LSP
      nil

      nodePackages."bash-language-server"
      nodePackages."dockerfile-language-server-nodejs"
      nodePackages."typescript"
      nodePackages."typescript-language-server"
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
# {
#   nixpkgs = {
#     overlays = [
#       (final: prev: {
#         vimPlugins = prev.vimPlugins // {
#           wlvs-nvim = prev.vimUtils.buildVimPlugin {
#             name = "wlvs-nvim";
#             src = ../../config/nvim;
#           };
#         };
#       })
#     ];
#   };
#
#   programs.neovim =
#   let
#     toLua = str: "lua << EOF\n${str}\nEOF\n";
#     toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
#     luaConfig = file: builtins.readFile file;
#
#     # noice-nvim-2_0_3 = pkgs.vimUtils.buildVimPlugin {
#     #   pname = "noice.nvim";
#     #   version = "2024-05-15";
#     #   src = pkgs.fetchFromGitHub {
#     #     owner = "folke";
#     #     repo = "noice.nvim";
#     #     rev = "8389ff59ec6eab87d7328a83e3f28ca96111d7b1";
#     #     sha256 = "m3vRKLuWrNkhHMgnpfRodTqBScaQlsIYnShsrpjKa+E=";
#     #   };
#     #   meta.homepage = "https://github.com/folke/noice.nvim/";
#     # };
#   in
#   {
#     enable = true;
#     # package = pkgs.neovim-nightly;
#
#     viAlias = true;
#     vimAlias = true;
#     vimdiffAlias = true;
#
#     plugins = with pkgs.vimPlugins; [
#       plenary-nvim
#       popup-nvim
#
#       nvim-lspconfig
#       nvim-cmp
#       cmp-nvim-lsp
#       cmp-buffer
#       cmp-path
#       cmp_luasnip
#
#       luasnip
#       friendly-snippets
#
#       nvim-treesitter.withAllGrammars
#       nvim-treesitter-context
#       rainbow-delimiters-nvim
#       nvim-ts-context-commentstring
#
#       rust-tools-nvim
#
#       telescope-nvim
#       telescope-fzf-native-nvim
#
#       kanagawa-nvim
#
#       better-escape-nvim
#       which-key-nvim
#       neoscroll-nvim
#       neogit
#       gitsigns-nvim
#       diffview-nvim
#       fzf-lua
#
#       toggleterm-nvim
#
#       mini-nvim
#       trouble-nvim
#       todo-comments-nvim
#
#       treesj
#
#       dressing-nvim
#       # bufferline-nvim
#       barbar-nvim
#       lualine-nvim
#       nvim-navic
#       indent-blankline-nvim
#       nvim-notify
#       noice-nvim
#       # noice-nvim-2_0_3
#       nvim-colorizer-lua
#       nui-nvim
#       nvim-web-devicons
#
#
#       # Add custom config from overlay
#       wlvs-nvim
#     ];
#
#     extraLuaConfig = ''
#       require 'wlvs'.init()
#     '';
#
#     extraPackages = with pkgs; [
#       lua-language-server
#
#       # Nix LSP
#       nil
#
#       nodePackages."bash-language-server"
#       nodePackages."dockerfile-language-server-nodejs"
#       nodePackages."typescript"
#       nodePackages."typescript-language-server"
#       nodePackages."vscode-langservers-extracted"
#       nodePackages."yaml-language-server"
#
#       gopls
#       gofumpt
#       golines
#       gotools
#
#       rust-analyzer
#
#       wl-clipboard
#       yarn
#     ];
#
#   };
# }
#
