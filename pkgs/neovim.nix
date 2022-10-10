{
  lib,
  neovim-unwrapped,
  neovimUtils,
  vimPlugins,
  wrapNeovimUnstable,
  # Formatters and Linters
  alejandra,
  statix,
  stylua,
  # LSP Servers
  nil,
  sumneko-lua-language-server,
  tailwind-intellisense,
  vscode-langservers-extracted,
  # Flake-local
  grammars,
}: let
  config = neovimUtils.makeNeovimConfig {
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    customRC = ''
      set rtp^=${../rtp}
      luafile ${./init.lua}
    '';

    plugins = with vimPlugins; let
      nvim-treesitter' = nvim-treesitter.withPlugins (p:
        (with p; [
          tree-sitter-bash
          tree-sitter-css
          tree-sitter-dockerfile
          tree-sitter-dot
          tree-sitter-elisp
          tree-sitter-elixir
          tree-sitter-embedded-template
          tree-sitter-erlang
          tree-sitter-fish
          tree-sitter-glsl
          tree-sitter-graphql
          tree-sitter-hcl
          tree-sitter-heex
          tree-sitter-html
          tree-sitter-javascript
          tree-sitter-json
          tree-sitter-latex
          tree-sitter-lua
          tree-sitter-make
          tree-sitter-markdown
          tree-sitter-markdown-inline
          tree-sitter-nix
          tree-sitter-regex
          tree-sitter-ruby
          tree-sitter-rust
          tree-sitter-scss
          tree-sitter-sql
          tree-sitter-toml
          tree-sitter-tsx
          tree-sitter-typescript
          tree-sitter-vim
          tree-sitter-yaml
        ])
        ++ (with grammars; [
          tree-sitter-eex
          tree-sitter-just
          tree-sitter-norg
          tree-sitter-norg-meta
          tree-sitter-norg-table
        ]));
    in [
      # Ad-hoc package management
      impatient-nvim
      packer-nvim
      # Appearance
      lualine-lsp-progress
      lualine-nvim
      nvim-base16
      todo-comments-nvim
      # Completion
      cmp-buffer
      cmp-cmdline
      cmp-git
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lsp-document-symbol
      cmp-nvim-lsp-signature-help
      cmp-nvim-lua
      cmp-path
      cmp-spell
      luasnip
      nvim-cmp
      # Editing
      comment-nvim
      direnv-vim
      emmet-vim
      indent-blankline-nvim
      nvim-colorizer-lua
      nvim-highlight-colors
      nvim-treesitter-textobjects
      pretty-fold-nvim
      trouble-nvim
      # Finder
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-project-nvim
      # File tree
      nvim-tree-lua
      nvim-web-devicons
      # Git
      diffview-nvim
      fugitive
      gitsigns-nvim
      vim-rhubarb
      # Keybinds
      which-key-nvim
      # Knowledge/Documentations
      neorg
      neorg-telescope
      # LSP
      lspkind-nvim
      neodev-nvim
      null-ls-nvim
      nvim-lspconfig
      nvim-navic
      SchemaStore-nvim
      # Syntax highlighting
      nvim-treesitter'
      vim-just
      # Utility
      mini-nvim
      neoconf
      # Workflow
      auto-session
      vim-projectionist
      # Languages
      ## Elixir
      elixir-nvim
      ## RDF
      vim-rdf
      ## Rust
      crates-nvim
      rust-tools-nvim
    ];
  };
in
  wrapNeovimUnstable neovim-unwrapped (config
    // {
      wrapperArgs =
        config.wrapperArgs
        ++ [
          "--suffix"
          "PATH"
          ":"
          (lib.makeBinPath [
            alejandra
            nil
            statix
            stylua
            sumneko-lua-language-server
            tailwind-intellisense
            vscode-langservers-extracted
          ])
        ];
    })
