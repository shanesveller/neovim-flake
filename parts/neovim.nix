{self, ...}: {
  perSystem = {
    config,
    inputs',
    lib,
    pkgs,
    ...
  }: {
    packages = let
      inherit (inputs'.neovim.packages) neovim;

      # Historical Nix-managed plugins
      plugins = with pkgs.vimPlugins; [
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
        friendly-snippets
        luasnip
        LuaSnip-snippets-nvim
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
        nvim-treesitter
        vim-just
        # Utility
        mini-nvim
        neoconf
        # Workflow
        persistence
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

      pluginsText = lib.trivial.pipe plugins [
        (builtins.map (p: ''
          "${p.src.owner}/${p.src.repo}",
        ''))
        (builtins.concatStringsSep "")
      ];
    in {
      default = config.packages.neovimConfigured;
      inherit neovim;
      neovimConfigured = pkgs.callPackage ../pkgs/neovim.nix {
        neovim-unwrapped = neovim;
        inherit self;
        inherit (config.legacyPackages) grammars;
        inherit (pkgs.nodePackages) vscode-langservers-extracted;
        tailwind-intellisense =
          pkgs.nodePackages."@tailwindcss/language-server";
      };

      pluginExport = pkgs.writeText "plugins.lua" pluginsText;
    };
  };
}
