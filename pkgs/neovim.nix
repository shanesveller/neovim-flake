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
  rnix-lsp,
  sumneko-lua-language-server,
  # Plugins
  elixir-nvim,
  pretty-fold-nvim,
  tree-sitter-eex,
  tree-sitter-just,
  vim-just,
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
        with p; [
          tree-sitter-bash
          tree-sitter-css
          tree-sitter-dockerfile
          tree-sitter-dot
          tree-sitter-eex
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
          tree-sitter-just
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
        ]);
    in [
      # Ad-hoc package management
      packer-nvim
      # Appearance
      lualine-nvim
      nvim-base16
      # Completion
      cmp-buffer
      cmp-cmdline
      cmp-git
      cmp-nvim-lua
      cmp-path
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
      fugitive
      gitsigns-nvim
      # Keybinds
      which-key-nvim
      # LSP
      fidget-nvim
      lspkind-nvim
      lua-dev-nvim
      null-ls-nvim
      nvim-lspconfig
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
          (lib.makeBinPath [alejandra rnix-lsp statix stylua sumneko-lua-language-server])
        ];
    })
