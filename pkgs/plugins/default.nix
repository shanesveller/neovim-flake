{
  buildVimPluginFrom2Nix,
  callPackage,
  vimPlugins,
  ...
}: let
  dependencies = with vimPlugins; {
    neorg = [plenary-nvim];
    pretty-fold-nvim = [nvim-lspconfig plenary-nvim];
  };

  sources' = callPackage ./generated.nix {};
in
  builtins.mapAttrs (pname: generated:
    buildVimPluginFrom2Nix generated
    // {
      dependencies = dependencies.${pname} or [];
    })
  sources'
