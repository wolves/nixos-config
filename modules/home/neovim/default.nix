{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.programs.neovim;

  nvim-window-picker = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "nvim-window-picker";
    version = "a53a3b7487a9f090f5405ead8dcd5ebf5b934e97";
    src = pkgs.fetchFromGitHub {
      owner = "s1n7ax";
      repo = pname;
      rev = version;
      sha256 = "s1UC2DGrl6g1scpwx5BbaSynl7z+p0UnwKbaUzIxygI=";
    };
  };
incline-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "incline-nvim";
    version = "44d4e6f4dcf2f98cf7b62a14e3c10749fc5c6e35";
    src = pkgs.fetchFromGitHub {
      owner = "b0o";
      repo = "incline.nvim";
      rev = version;
      sha256 = "oXmZK4cVyuSqmDUwJK0v7YL2g3Kr7zbMgk178D+zzys=";
    };
  };
in {
  options.modules.programs.neovim = { enable = mkEnableOption "neovim"; };

  config = mkIf cfg.enable {
    #xdg.configFile."nvim".source = ./nvim;

    home.packages = with pkgs; [
      sumneko-lua-language-server
      stylua
      shellcheck
      rust-analyzer
      alejandra
      gopls
      shfmt
      #marksman
      nodejs
      nodePackages.prettier
      nodePackages.stylelint
      nodePackages.jsonlint
      #nodePackages.markdownlint
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.vscode-json-languageserver
      nodePackages.yarn
      nodePackages.bash-language-server
      nodePackages.svelte-language-server
      #nodePackages.tailwindcss-language-server
      nodePackages.yaml-language-server
    ];

    programs.neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;
      withRuby = false;
      withNodeJs = false;
      withPython3 = false;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        {
          plugin = which-key-nvim;
          type = "lua";
          config = builtins.readFile(./nvim/lua/config/mappings.lua);
        }
        {
          plugin = kanagawa-nvim;
          type = "lua";
          config = builtins.readFile(./nvim/lua/plugins/kanagawa.lua);
        }
        noice-nvim
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile(./nvim/lua/plugins/telescope.lua);
        }
        telescope-fzf-native-nvim
        nvim-lspconfig
        #mason-nvim
        #mason-lspconfig-nvim
        #typescript-nvim
        null-ls-nvim
        #schemastore-nvim
        trouble-nvim
        rust-tools-nvim
        nvim-web-devicons
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp_luasnip
        cmp-nvim-lsp-signature-help
        {
          plugin = bufferline-nvim;
          type = "lua";
          config = builtins.readFile(./nvim/lua/plugins/bufferline.lua);
        }
        vim-bbye
        {
          plugin = neo-tree-nvim;
          type = "lua";
          config = builtins.readFile(./nvim/lua/plugins/neo-tree.lua);
        }
        {
          plugin = nvim-window-picker;
          type = "lua";
          config = ''
            require("window-picker").setup({
              autoselect_one = true,
              include_current = false,
              filter_rules = {
                bo = {
                  filetype = { "neo-tree-popup", "quickfix", "incline" },
                  buftype = { "terminal", "quickfix", "nofile" },
                },
              },
            })
          '';
        }
        nui-nvim
        nvim-notify
        toggleterm-nvim
        {
          plugin = neoscroll-nvim;
          type = "lua";
          config = builtins.readFile(./nvim/lua/plugins/neoscroll.lua);
        }
        {
          plugin = better-escape-nvim;
          type = "lua";
          config = builtins.readFile(./nvim/lua/plugins/better-escape.lua);
        }
        indent-blankline-nvim
        nvim-colorizer-lua
        todo-comments-nvim
        {
          plugin = nvim-navic;
          type = "lua";
          config = ''
            vim.g.navic_silence = true
            require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
          '';
        }
        {
          plugin = lualine-nvim;
          type = "lua";
          config = builtins.readFile(./nvim/lua/plugins/lualine.lua);
        }
        incline-nvim
        {
          plugin = comment-nvim;
          type = "lua";
          #config = builtins.readFile(./nvim/lua/plugins/comment.lua);
          config = ''
            require("Comment").setup({})
          '';
        }
        nvim-autopairs
        luasnip
        friendly-snippets
        #tabout-nvim
        nvim-surround
        splitjoin-vim
        #inc-rename-nvim
        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = builtins.readFile(./nvim/lua/plugins/gitsigns.lua);
        }
        {
          plugin = neogit;
          type = "lua";
          config = builtins.readFile(./nvim/lua/plugins/neogit.lua);
        }
        diffview-nvim
        vim-startuptime
        nvim-ts-autotag
        nvim-ts-rainbow
        #crates-nvim
        #lspkind-nvim
        (nvim-treesitter.withPlugins (plugins:
        with plugins; [
          tree-sitter-bash
          tree-sitter-css
          tree-sitter-fish
          tree-sitter-gitignore
          tree-sitter-go
          tree-sitter-help
          tree-sitter-html
          tree-sitter-http
          tree-sitter-javascript
          tree-sitter-json
          tree-sitter-lua
          tree-sitter-markdown
          tree-sitter-markdown_inline
          tree-sitter-nix
          tree-sitter-norg
          tree-sitter-regex
          tree-sitter-rust
          tree-sitter-scss
          tree-sitter-sql
          tree-sitter-svelte
          tree-sitter-toml
          tree-sitter-tsx
          tree-sitter-typescript
          tree-sitter-vim
          tree-sitter-yaml
        ]))
      ];
      extraConfig = ''
        luafile $NIXOS_CONFIG_DIR/modules/home/neovim/nvim/lua/config/options.lua
        luafile $NIXOS_CONFIG_DIR/modules/home/neovim/nvim/lua/plugins/indent-blankline.lua
        luafile $NIXOS_CONFIG_DIR/modules/home/neovim/nvim/lua/plugins/incline.lua
      '';
    };
  };
}
