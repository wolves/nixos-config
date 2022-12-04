{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.programs.neovim;
in {
  options.modules.programs.neovim = { enable = mkEnableOption "neovim"; };

  config = mkIf cfg.enable {
    xdg.configFile."nvim".source = ./nvim;

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
        kanagawa-nvim
        noice-nvim
        which-key-nvim
        telescope-nvim
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
        bufferline-nvim
        vim-bbye
        neo-tree-nvim
        #nvim-window-picker
        nui-nvim
        nvim-notify
        toggleterm-nvim
        neoscroll-nvim
        better-escape-nvim
        indent-blankline-nvim
        nvim-colorizer-lua
        todo-comments-nvim
        lualine-nvim
        #incline-nvim
        comment-nvim
        nvim-autopairs
        luasnip
        friendly-snippets
        #tabout-nvim
        nvim-surround
        splitjoin-vim
        #inc-rename-nvim
        gitsigns-nvim
        neogit
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
    };
  };
}
