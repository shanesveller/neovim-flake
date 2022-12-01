_: {
  perSystem = _: {
    pre-commit = {
      settings = {
        hooks = {
          alejandra.enable = true;
          statix.enable = true;
          stylua.enable = true;
        };
        settings = {statix.ignore = [".direnv/*"];};
      };
    };
  };
}
