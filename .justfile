default: run

build:
	nix -vL build .#neovimConfigured

changelog:
  clog -i CHANGELOG.md -o CHANGELOG.md -F --setversion Unreleased

fetch-grammar mask=".":
  cd grammars && nvfetcher -vt -f '{{ mask }}' -c sources.toml -l ../grammar-changes.txt -o .
  alejandra --quiet grammars/generated.nix
  git add grammars/
  git commit -m 'chore(tree-sitter): Update nvfetcher grammars' -m "$(cat grammar-changes.txt)"
  rm grammar-changes.txt

fetch-plugin mask=".":
  cd plugins && nvfetcher -vt -f '{{ mask }}' -c sources.toml -l ../plugin-changes.txt -o .
  alejandra --quiet plugins/generated.nix
  git add plugins/
  git commit -m 'chore(plugins): Update nvfetcher plugins' -m "$(cat plugin-changes.txt)"
  rm plugin-changes.txt

readme:
  nix -vL run ~/src/neovim-flake#neovimConfigured -- README.norg +"Neorg export to-file README.md"

run *args:
	nix -vL run .#neovimConfigured -- {{ args }}

profile:
	truncate -s 0 profile.txt
	env STARTUP_PROFILE=1 nix -vL run .#neovimConfigured -- --startuptime profile.txt +q
	less profile.txt

tree:
	nix build .#neovimConfigured
	nix-tree ./result
