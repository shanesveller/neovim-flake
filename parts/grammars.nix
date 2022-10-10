{inputs, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: let
    grammars = pkgs.callPackages ../grammars {
      inherit inputs lib pkgs;
    };
  in {
    legacyPackages = {inherit grammars;};
    packages = builtins.removeAttrs grammars ["override" "overrideDerivation"];
  };
}
