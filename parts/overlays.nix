{
  inputs,
  self,
  ...
}: {
  perSystem = {system, ...}: let
    pkgs = import inputs.nixpkgs {
      config = {};
      overlays = [self.overlays.extendPlugins];
      inherit system;
    };
  in {config = {_module.args.pkgs = pkgs;};};
}
