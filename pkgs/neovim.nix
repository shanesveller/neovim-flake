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
  # Build native extensions
  gcc,
  gnumake,
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
          tree-sitter-dot
          tree-sitter-elisp
          tree-sitter-erlang
          tree-sitter-fish
          tree-sitter-glsl
          tree-sitter-latex
          tree-sitter-regex
          tree-sitter-tsx
          tree-sitter-typescript
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
            # LSP and linters
            alejandra
            nil
            statix
            stylua
            sumneko-lua-language-server
            tailwind-intellisense
            vscode-langservers-extracted
            # Compiling native extensions
            gcc
            gnumake
          ])
        ];
    })
