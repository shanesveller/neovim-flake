{
  description = "Shane Sveller's personal Neovim config";

  inputs = {
    flake-parts.inputs.nixpkgs.follows = "nixpkgs";
    neovim.url = "github:neovim/neovim?dir=contrib";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
        packages = {
          inherit (inputs'.neovim.packages) neovim;

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
