{
  lib,
  self,
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
      set rtp^=${self}/rtp
      luafile ${self}/pkgs/init.lua
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
          tree-sitter-jsonc
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
      # Syntax highlighting
      nvim-treesitter'
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
