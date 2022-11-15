{
  description = "Shane Sveller's personal Neovim config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    neovim.url = "github:neovim/neovim/v0.8.1?dir=contrib";
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
      imports = [
        # Order-sensitive
        ./parts/overlays.nix
        # Order-insensitive
        ./parts/checks.nix
        ./parts/devshell.nix
        ./parts/grammars.nix
        ./parts/neovim.nix
        ./parts/plugins.nix
        # Third-party
        inputs.pre-commit-hooks.flakeModule
      ];
      systems = ["aarch64-darwin" "x86_64-darwin" "x86_64-linux"];
    };
}
