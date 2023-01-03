{inputs, ...}: {
  perSystem = {
    config,
    inputs',
    pkgs,
    ...
  }: {
    devShells.default = let
      lspServers = with pkgs; [nil sumneko-lua-language-server];
      linters = with inputs'.pre-commit-hooks.packages; [
        alejandra
        pre-commit
        statix
        stylua
      ];
      local = with config.packages; [nvfetcher];
      utilities = with pkgs; [just nix-tree];
    in
      pkgs.mkShell {
        packages = utilities ++ local ++ linters ++ lspServers;
        shellHook = config.pre-commit.installationScript;
      };

    formatter = pkgs.symlinkJoin {
      name = "alejandra";
      paths = [pkgs.alejandra];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/alejandra \
          --add-flags '--quiet'
      '';
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
