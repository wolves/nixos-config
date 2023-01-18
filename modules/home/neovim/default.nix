{
  pkgs,
  lib,
  ...
}:
with lib; let
  mini-bufremove = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "mini.bufremove";
    version = "3a412070c8c264327eb57e9e14761c07b018b75a";
    src = pkgs.fetchFromGitHub {
      owner = "echasnovski";
      repo = pname;
      rev = version;
      sha256 = "EvFXd1dl0eCBAEncDUD7RUOXkqNb/vAAfTk0ppz/H54=";
    };
  };

  mini-comment = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "mini.comment";
    version = "a0f543e7846f67d10cbed5f2dce72eb26d0ca96b";
    src = pkgs.fetchFromGitHub {
      owner = "echasnovski";
      repo = pname;
      rev = version;
      sha256 = "bJhPXvs2UwuBRe9Y6svxkQqgmNIEnsRsmfNlHOmD33w=";
    };
  };

  mini-indentscope = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "mini.indentscope";
    version = "59c73c6965f9fa74cd2c1351339a58778e68e589";
    src = pkgs.fetchFromGitHub {
      owner = "echasnovski";
      repo = pname;
      rev = version;
      sha256 = "UQ49ZWkbjJkP3j5DLrITNxQG5nuVzX6pnm2aYGOwQdc=";
    };
  };
in {
  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      bufferline-nvim
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-emoji
      cmp_luasnip
      dressing-nvim
      neogit
      null-ls-nvim
      gitsigns-nvim
      indent-blankline-nvim
      kanagawa-nvim
      lualine-nvim
      mini-bufremove
      mini-comment
      mini-indentscope
      neo-tree-nvim
      noice-nvim
      nui-nvim
      nvim-colorizer-lua
      nvim-cmp
      nvim-lspconfig
      nvim-notify
      nvim-spectre
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      nvim-ts-context-commentstring
      nvim-web-devicons
      plenary-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      todo-comments-nvim
      toggleterm-nvim
      trouble-nvim
      vim-illuminate
      vim-nix
      which-key-nvim
    ];

    extraPackages = with pkgs; [
      fd
      gcc
      nodejs
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      ripgrep
      sumneko-lua-language-server
    ];

    extraConfig = let
      luaRequire = module:
        builtins.readFile (builtins.toString
	  ./config
	  + "/${module}.lua");
      luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
        "autocmds"
        "options"
        "bufferline"
        "gitsigns"
        "kanagawa"
        "mini-comment"
        "mini-indentscope"
        "neogit"
        "telescope"
	      "which-key"
      ]);
    in ''
      lua <<
      ${luaConfig}

    '';
  };
}
