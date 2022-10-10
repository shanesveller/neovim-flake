_: {
  perSystem = {
    config,
    inputs',
    pkgs,
    ...
  }: {
    packages = let
      inherit (inputs'.neovim.packages) neovim;
    in {
      inherit neovim;
      neovimConfigured = pkgs.callPackage ../pkgs/neovim.nix {
        neovim-unwrapped = neovim;
        inherit
          (config.packages)
          tree-sitter-eex
          tree-sitter-just
          tree-sitter-norg
          tree-sitter-norg-meta
          tree-sitter-norg-table
          ;
      };
    };
  };
}
