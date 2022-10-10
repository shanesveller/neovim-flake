_: {
  perSystem = {pkgs, ...}: let
    plugins = pkgs.callPackage ../pkgs/plugins {
      inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
    };
  in {
    legacyPackages = {inherit plugins;};
    packages = builtins.removeAttrs plugins ["override" "overrideDerivation"];
  };
}
