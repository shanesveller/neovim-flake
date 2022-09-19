{
  buildVimPluginFrom2Nix,
  fetchFromGitHub,
  vimPlugins,
}: let
  pname = "other.nvim";
in
  buildVimPluginFrom2Nix {
    inherit pname;
    dependencies = with vimPlugins; [nvim-lspconfig plenary-nvim];
    version = "2022-08-03-unstable";
    src = fetchFromGitHub {
      owner = "rgroli";
      repo = pname;
      rev = "a2ae9e03d08c6c5e8f60cc1db58cbf4ada2ae338";
      sha256 = "sha256-knAHH4cxCxBTCZb54BERyR3l6+uhzZ3k9yPSzAl/4W0=";
    };
  }
