{inputs, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: let
    grammars =
      builtins.removeAttrs
      (pkgs.callPackages ../grammars {
        inherit inputs lib pkgs;
      })
      ["override" "overrideDerivation"];
  in {
    legacyPackages = {inherit grammars;};
    packages = grammars;
  };
}
