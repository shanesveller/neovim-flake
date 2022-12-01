{
  callPackage,
  inputs,
  ...
}: let
  mkGrammar = callPackage (inputs.nixpkgs + /pkgs/development/tools/parsing/tree-sitter/grammar.nix) {};
  sources' = callPackage ./generated.nix {};
in
  builtins.mapAttrs (
    _pname: generated:
      mkGrammar {
        language = builtins.replaceStrings ["tree-sitter-"] [""] generated.pname;
        inherit (generated) version;
        source = generated.src;
      }
  )
  sources'
