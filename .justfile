default: run

build:
	nix -vL build .#neovimConfigured

changelog:
  clog -i CHANGELOG.md -o CHANGELOG.md -F --setversion Unreleased

clean:
  rm -rf ~/.cache/nvim/ ~/.config/nvim/ ~/.local/share/nvim/* ~/.local/state/nvim/lazy/

fetch-grammar mask=".":
  cd grammars && nvfetcher -vt -f '{{ mask }}' -c sources.toml -l ../grammar-changes.txt -o .
  alejandra --quiet grammars/generated.nix
  git add grammars/
  git commit -m 'chore(tree-sitter): Update nvfetcher grammars' -m "$(cat grammar-changes.txt)"
  rm grammar-changes.txt

impure:
  mkdir -p ~/.config/nvim
  find ~/.config/nvim -type l -print -delete
  ln -sf $PWD/pkgs/init.lua ~/.config/nvim/init.lua
  ln -sf $PWD/rtp/lua ~/.config/nvim/lua
  ln -sf $PWD/rtp/luasnippets ~/.config/nvim/luasnippets

readme:
  nix -vL run ~/src/neovim-flake#neovimConfigured -- README.norg +"Neorg export to-file README.md"

run *args:
	nix -vL run .#neovimConfigured -- {{ args }}

profile:
	truncate -s 0 profile.txt
	nix -vL run .#neovimConfigured -- --startuptime profile.txt +q
	less profile.txt

tree:
	nix build .#neovimConfigured
	nix-tree ./result
