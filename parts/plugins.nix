_: {
  perSystem = {pkgs, ...}: {
    packages = pkgs.callPackages ../pkgs/plugins {
      inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
    };
  };
}
