{  config, pkgs, ... }:

{
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

      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = luaConfig ./nvim/plugin/treesitter.lua;
      }
      nvim-treesitter-context
      nvim-ts-rainbow2

      {
        plugin = telescope-nvim;
        type = "lua";
        config = luaConfig ./nvim/plugin/telescope.lua;
      }
      telescope-fzf-native-nvim

      {
        plugin = kanagawa-nvim;
        type = "lua";
        config = luaConfig ./nvim/plugin/kanagawa.lua;
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = luaConfig ./nvim/plugin/which-key.lua;
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';
  };
}
