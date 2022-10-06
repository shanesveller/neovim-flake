{inputs, ...}: {
  perSystem = {
    config,
    system,
    ...
  }: {
    checks.pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
      src = ./.;
      hooks = {
        alejandra.enable = true;
        statix.enable = true;
        stylua.enable = true;
      };
      settings = {statix.ignore = [".direnv/*"];};
    };
  };
}
