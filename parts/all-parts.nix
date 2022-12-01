_: {
  imports = [
    # Order-sensitive
    ./overlays.nix
    # Order-insensitive
    ./checks.nix
    ./devshell.nix
    ./grammars.nix
    ./neovim.nix
    ./plugins.nix
  ];
}
