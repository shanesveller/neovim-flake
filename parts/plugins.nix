{
  lib,
  self,
  ...
}: let
  extendPlugins = _final: prev: {
    vimPlugins = prev.vimPlugins.extend (
      _f: p:
        lib.trivial.pipe self.legacyPackages.${prev.system}.plugins [
          stripOverrides
          (builtins.mapAttrs (n: v:
            if p ? n
            then (builtins.trace "falling back to nixpkgs for vimPlugins.${n}" p.${n})
            else v))
        ]
    );
  };
  stripOverrides = subject: builtins.removeAttrs subject ["override" "overrideDerivation"];
in {
  flake.overlays = {
    inherit extendPlugins;
  };

  perSystem = {pkgs, ...}: let
    plugins = pkgs.callPackage ../plugins {
      inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
    };
  in {
    legacyPackages = {inherit plugins;};
    packages = stripOverrides plugins;
  };
}
