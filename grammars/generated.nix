# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
}: {
  tree-sitter-eex = {
    pname = "tree-sitter-eex";
    version = "f742f2fe327463335e8671a87c0b9b396905d1d1";
    src = fetchFromGitHub {
      owner = "connorlay";
      repo = "tree-sitter-eex";
      rev = "f742f2fe327463335e8671a87c0b9b396905d1d1";
      fetchSubmodules = false;
      sha256 = "sha256-UPq62MkfGFh9m/UskoB9uBDIYOcotITCJXDyrbg/wKY=";
    };
  };
  tree-sitter-just = {
    pname = "tree-sitter-just";
    version = "8af0aab79854aaf25b620a52c39485849922f766";
    src = fetchFromGitHub {
      owner = "IndianBoy42";
      repo = "tree-sitter-just";
      rev = "8af0aab79854aaf25b620a52c39485849922f766";
      fetchSubmodules = false;
      sha256 = "sha256-hYKFidN3LHJg2NLM1EiJFki+0nqi1URnoLLPknUbFJY=";
    };
  };
  tree-sitter-norg = {
    pname = "tree-sitter-norg";
    version = "6348056b999f06c2c7f43bb0a5aa7cfde5302712";
    src = fetchFromGitHub {
      owner = "nvim-neorg";
      repo = "tree-sitter-norg";
      rev = "6348056b999f06c2c7f43bb0a5aa7cfde5302712";
      fetchSubmodules = false;
      sha256 = "sha256-5g4K+pYpS0DyYShKAoBCe6PD1wEZ+bvYMuI+ZbNPgJI=";
    };
  };
  tree-sitter-norg-meta = {
    pname = "tree-sitter-norg-meta";
    version = "8e1a9008eb9492e95eb9a65ab0ec0419cfa9c4c7";
    src = fetchFromGitHub {
      owner = "nvim-neorg";
      repo = "tree-sitter-norg-meta";
      rev = "8e1a9008eb9492e95eb9a65ab0ec0419cfa9c4c7";
      fetchSubmodules = false;
      sha256 = "sha256-1gOTQdqB/TpaJ2ClNY+/Gqsj7TkCgv9CNiX97oF8PGo=";
    };
  };
  tree-sitter-norg-table = {
    pname = "tree-sitter-norg-table";
    version = "d931ad0900a3bb9141a2b709c6053c5adf09a0b9";
    src = fetchFromGitHub {
      owner = "nvim-neorg";
      repo = "tree-sitter-norg-table";
      rev = "d931ad0900a3bb9141a2b709c6053c5adf09a0b9";
      fetchSubmodules = false;
      sha256 = "sha256-r668hZtAMs5+wG/bfzuskBcXXuOdMtSw4siamlGq4yw=";
    };
  };
}
