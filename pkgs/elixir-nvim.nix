{
  buildVimPluginFrom2Nix,
  fetchFromGitHub,
  vimPlugins,
}: let
  pname = "elixir.nvim";
in
  buildVimPluginFrom2Nix {
    inherit pname;
    dependencies = with vimPlugins; [nvim-lspconfig plenary-nvim];
    version = "2022-09-05-unstable";
    src = fetchFromGitHub {
      owner = "mhanberg";
      repo = pname;
      rev = "7796fe00f49612d9b93934a3b9c14ee0b24d1604";
      sha256 = "sha256-VwvV7IUJJaAEUqMIVged596lxeZv6VKtyusLWaDi/Qc=";
    };
  }
