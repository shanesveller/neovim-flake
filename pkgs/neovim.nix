{
  fetchFromGitHub,
  lib,
  neovim-unwrapped,
  neovimUtils,
  runCommand,
  symlinkJoin,
  vimPlugins,
  vimUtils,
  wrapNeovimUnstable,
  writeTextFile,
  # Formatters and Linters
  alejandra,
  statix,
  stylua,
  # LSP Servers
  nil,
  sumneko-lua-language-server,
  # Flake-local
  grammars,
}: let
  config = neovimUtils.makeNeovimConfig {
    extraLuaPackages = luaPackages: [];
    extraPython3Packages = pythonPackages: [];

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    customRC = ''
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
      packer-nvim
      # Appearance
      lualine-lsp-progress
      lualine-nvim
      nvim-base16
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
      indent-blankline-nvim
      pretty-fold-nvim
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
      # Syntax highlighting
      nvim-treesitter'
      vim-just
      # Utility
      mini-nvim
      # Workflow
      vim-projectionist
      # Languages
      ## Elixir
      elixir-nvim
      ## Rust
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
          (lib.makeBinPath [alejandra nil statix stylua sumneko-lua-language-server])
        ];
    })
