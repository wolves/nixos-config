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

  mini-pairs = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "mini.pairs";
    version = "01ff683bf13839f5a56b765e89591f418ffe1e2c";
    src = pkgs.fetchFromGitHub {
      owner = "echasnovski";
      repo = pname;
      rev = version;
      sha256 = "m4EXaiFbJIfnv7mM/oH4zk5iglR8MMij6hfWOf9Foxc=";
    };
  };

  mini-surround = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "mini.surround";
    version = "aeeb1c4ce4d1c66211bdc74b131c11b8fcbae65e";
    src = pkgs.fetchFromGitHub {
      owner = "echasnovski";
      repo = pname;
      rev = version;
      sha256 = "1Q1PlknNhkl9gpwTVMSqCQ9LlaRRge+1Yb/iBwbWlH8=";
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
      { plugin = mini-pairs; type = "lua"; config = "require('mini.pairs').setup({})"; }
      mini-surround
      neo-tree-nvim
      noice-nvim
      nui-nvim
      nvim-colorizer-lua
      nvim-cmp
      nvim-lspconfig
      nvim-notify
      nvim-spectre
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      nvim-treesitter-textobjects
      nvim-ts-context-commentstring
      nvim-web-devicons
      plenary-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      todo-comments-nvim
      toggleterm-nvim
      trouble-nvim
      vim-illuminate
      { plugin = vim-matchup; type = "lua"; config = "vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }"; }
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
        "mini-surround"
        "neogit"
        "noice"
        "telescope"
	      "which-key"
      ]);
    in ''
      lua <<
      ${luaConfig}

    '';
  };
}
