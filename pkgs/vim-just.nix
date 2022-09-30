{
  buildVimPluginFrom2Nix,
  fetchFromGitHub,
  vimPlugins,
}: let
  pname = "vim-just";
in
  buildVimPluginFrom2Nix {
    inherit pname;
    version = "2022-08-03-unstable";
    src = fetchFromGitHub {
      owner = "NoahTheDuke";
      repo = pname;
      rev = "312615d5b4c4aa2595d697faca5af345ba8fe102";
      sha256 = "sha256-8qGFYRoVIiGB240wdM0o9hCMt65Gg4qIh7pvmW3DghU=";
    };
  }
