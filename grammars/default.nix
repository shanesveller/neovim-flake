{
  callPackage,
  inputs,
  lib,
  pkgs,
  ...
}: let
  grammarSrc = inputs.nixpkgs + /pkgs/development/tools/parsing/tree-sitter/grammar.nix;
  sources' = callPackage ./generated.nix {};
in
  builtins.mapAttrs (
    pname: generated:
      (callPackage grammarSrc {}) {
        language = builtins.replaceStrings ["tree-sitter-"] [""] generated.pname;
        inherit (generated) version;
        source = generated.src;
      }
  )
  sources'
