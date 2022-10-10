{
  callPackage,
  inputs,
  lib,
  pkgs,
  ...
}: let
  mkGrammar = callPackage (inputs.nixpkgs + /pkgs/development/tools/parsing/tree-sitter/grammar.nix) {};
  sources' = callPackage ./generated.nix {};
in
  builtins.mapAttrs (
    pname: generated:
      mkGrammar {
        language = builtins.replaceStrings ["tree-sitter-"] [""] generated.pname;
        inherit (generated) version;
        source = generated.src;
      }
  )
  sources'
