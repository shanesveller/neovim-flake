{inputs, ...}: {
  perSystem = {
    config,
    inputs',
    lib,
    pkgs,
    self',
    system,
    ...
  }: {
    devShells.default = let
      lspServers = with pkgs; [nil sumneko-lua-language-server];
      linters = with inputs'.pre-commit-hooks.packages; [alejandra nix-linter pre-commit statix stylua];
      local = with config.packages; [nvfetcher];
      utilities = with pkgs; [just nix-tree];
    in
      pkgs.mkShell {
        packages = utilities ++ local ++ linters ++ lspServers;
        inherit (config.checks.pre-commit-check) shellHook;
      };

    packages.nvfetcher = pkgs.symlinkJoin {
      name = "nvfetcher";
      paths = [pkgs.nvfetcher];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/nvfetcher \
          --set NIX_PATH nixpkgs=${inputs.nixpkgs}
      '';
    };
  };
}
