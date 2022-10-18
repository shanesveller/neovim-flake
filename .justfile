default: run

build:
	nix -vL build .#neovimConfigured

changelog:
  clog --from main -i /dev/null -o CHANGELOG.md

fetch-grammar mask=".":
  cd grammars && nvfetcher -vt -f '{{ mask }}' -c sources.toml -o .
  alejandra --quiet grammars/generated.nix

fetch-plugin mask=".":
  cd pkgs/plugins && nvfetcher -vt -f '{{ mask }}' -c sources.toml -o .
  alejandra --quiet pkgs/plugins/generated.nix

readme:
  nix -vL run ~/src/neovim-flake#neovimConfigured -- README.norg +"Neorg export to-file README.md"

run args="":
	nix -vL run .#neovimConfigured -- {{ args }}

profile:
	truncate -s 0 profile.txt
	nix -vL run .#neovimConfigured -- --startuptime profile.txt +q
	less profile.txt

tree:
	nix build .#neovimConfigured
	nix-tree ./result
