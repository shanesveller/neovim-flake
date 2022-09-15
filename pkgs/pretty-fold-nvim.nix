{
  buildVimPluginFrom2Nix,
  fetchFromGitHub,
  vimPlugins,
}: let
  pname = "pretty-fold.nvim";
in
  buildVimPluginFrom2Nix {
    inherit pname;
    dependencies = with vimPlugins; [nvim-lspconfig plenary-nvim];
    version = "2022-07-20-unstable";
    src = fetchFromGitHub {
      owner = "anuvyklack";
      repo = pname;
      rev = "a7d8b424abe0eedf50116c460fbe6dfd5783b1d5";
      sha256 = "sha256-PQPZw0qXwMtpVE4uSxR3xUvkHE9iG4T+ZwgV6H9pUjo=";
    };
  }
