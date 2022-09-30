{
  description = "Shane Sveller's personal Neovim config";

  inputs = {
    flake-parts.inputs.nixpkgs.follows = "nixpkgs";
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
        self',
        inputs',
        pkgs,
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
        devShells.default = pkgs.mkShell {
          packages = (with pkgs; [just nix-tree]) ++ (with inputs'.pre-commit-hooks.packages; [alejandra nix-linter pre-commit statix stylua]);
          inherit (config.checks.pre-commit-check) shellHook;
        };
        packages = let
          inherit (inputs'.neovim.packages) neovim;
          callVim = path: extra:
            pkgs.callPackage path ({
                inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
              }
              // extra);
        in {
          elixir-nvim = callVim ./pkgs/elixir-nvim.nix {};

          inherit neovim;
          neovimConfigured = pkgs.callPackage ./pkgs/neovim.nix {
            neovim-unwrapped = neovim;
            inherit (config.packages) elixir-nvim pretty-fold-nvim tree-sitter-eex tree-sitter-just vim-just;
          };

          pretty-fold-nvim = callVim ./pkgs/pretty-fold-nvim.nix {};

          tree-sitter-eex =
            pkgs.callPackage
            (inputs.nixpkgs + /pkgs/development/tools/parsing/tree-sitter/grammar.nix) {} {
              language = "eex";
              version = "0.1.0";
              source = pkgs.fetchFromGitHub {
                owner = "connorlay";
                repo = "tree-sitter-eex";
                rev = "v0.1.0";
                sha256 = "sha256-UPq62MkfGFh9m/UskoB9uBDIYOcotITCJXDyrbg/wKY=";
              };
            };

          tree-sitter-just =
            pkgs.callPackage
            (inputs.nixpkgs + /pkgs/development/tools/parsing/tree-sitter/grammar.nix) {} {
              language = "just";
              version = "unstable-2021-11-02";
              source = pkgs.fetchFromGitHub {
                owner = "IndianBoy42";
                repo = "tree-sitter-just";
                rev = "8af0aab79854aaf25b620a52c39485849922f766";
                sha256 = "sha256-hYKFidN3LHJg2NLM1EiJFki+0nqi1URnoLLPknUbFJY=";
              };
            };

          vim-just = callVim ./pkgs/vim-just.nix {};
        };
      };
      flake = {};
    };
}
