{
  description = "Shane Sveller's personal Neovim config";

  inputs = {
    flake-parts.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    # https://github.com/neovim/neovim/compare/v0.8.0...47e60da7210209330767615c234ce181b6b67a08
    neovim.url = "github:neovim/neovim/47e60da7210209330767615c234ce181b6b67a08?dir=contrib";
    neovim.inputs.flake-utils.follows = "flake-utils";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.flake-utils.follows = "flake-utils";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit self;} {
      imports = [];
      systems = ["aarch64-darwin" "x86_64-darwin" "x86_64-linux"];
      perSystem = {
        config,
        inputs',
        lib,
        pkgs,
        self',
        system,
        ...
      }: {
        checks.pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            alejandra.enable = true;
            statix.enable = true;
            stylua.enable = true;
          };
          settings = {statix.ignore = [".direnv/*"];};
        };
        devShells.default = let
          lspServers = with pkgs; [rnix-lsp sumneko-lua-language-server];
          linters = with inputs'.pre-commit-hooks.packages; [alejandra nix-linter pre-commit statix stylua];
          local = with config.packages; [nvfetcher];
          utilities = with pkgs; [just nix-tree];
        in
          pkgs.mkShell {
            packages = utilities ++ local ++ linters ++ lspServers;
            inherit (config.checks.pre-commit-check) shellHook;
          };
        packages = let
          inherit (inputs'.neovim.packages) neovim;
          grammars = pkgs.callPackages ./grammars {
            inherit inputs lib pkgs;
          };
          plugins = pkgs.callPackages ./pkgs/plugins {
            inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
          };
        in {
          inherit neovim;
          neovimConfigured = pkgs.callPackage ./pkgs/neovim.nix {
            neovim-unwrapped = neovim;
            inherit (plugins) elixir-nvim pretty-fold-nvim vim-just;
            inherit
              (grammars)
              tree-sitter-eex
              tree-sitter-just
              ;
          };

          nvfetcher = pkgs.symlinkJoin {
            name = "nvfetcher";
            paths = [pkgs.nvfetcher];
            nativeBuildInputs = [pkgs.makeWrapper];
            postBuild = ''
              wrapProgram $out/bin/nvfetcher \
                --set NIX_PATH nixpkgs=${inputs.nixpkgs}
            '';
          };

          inherit (plugins) elixir-nvim other-nvim pretty-fold-nvim vim-just;
          inherit
            (grammars)
            tree-sitter-eex
            tree-sitter-just
            ;
        };
      };
    };
}
