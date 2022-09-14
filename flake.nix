{
  description = "Shane Sveller's personal Neovim config";

  inputs = {
    flake-parts.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    neovim.url = "github:neovim/neovim?dir=contrib";
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
      systems = ["x86_64-linux" "aarch64-darwin"];
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
        in {
          inherit neovim;
          neovimConfigured = pkgs.callPackage ./pkgs/neovim.nix {neovim-unwrapped = neovim;};

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
        };
      };
      flake = {};
    };
}
