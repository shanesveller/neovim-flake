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
      default = config.packages.neovimConfigured;
      inherit neovim;
      neovimConfigured = pkgs.callPackage ../pkgs/neovim.nix {
        neovim-unwrapped = neovim;
        inherit (config.legacyPackages) grammars;
      };
    };
  };
}
