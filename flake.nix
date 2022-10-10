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

  outputs = {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit self;} {
      imports = [
        # Order-sensitive
        ./parts/overlays.nix
        # Order-insensitive
        ./parts/checks.nix
        ./parts/devshell.nix
        ./parts/grammars.nix
        ./parts/neovim.nix
        ./parts/plugins.nix
      ];
      systems = ["aarch64-darwin" "x86_64-darwin" "x86_64-linux"];
    };
}
