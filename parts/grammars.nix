{inputs, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages = pkgs.callPackages ../grammars {
      inherit inputs lib pkgs;
    };
  };
}
