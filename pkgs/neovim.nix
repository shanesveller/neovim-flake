{
  lib,
  makeWrapper,
  neovim-unwrapped,
  symlinkJoin,
  # Lazy.nvim
  gitMinimal,
  # Formatters and Linters
  alejandra,
  statix,
  stylua,
  # LSP Servers
  nil,
  sumneko-lua-language-server,
  tailwind-intellisense,
  vscode-langservers-extracted,
  # CLI dependencies
  fd,
  ripgrep,
  # Build native extensions
  gcc,
  gnumake,
}:
symlinkJoin {
  name = "nvim";
  paths = [neovim-unwrapped];
  buildInputs = [makeWrapper];
  postBuild = ''
    wrapProgram $out/bin/nvim \
      --suffix PATH ":" ${
      lib.makeBinPath [
        # CLI dependencies
        fd
        ripgrep
        # LSP and linters
        alejandra
        gitMinimal
        nil
        statix
        stylua
        sumneko-lua-language-server
        tailwind-intellisense
        vscode-langservers-extracted
        # Compiling native extensions
        gcc
        gnumake
      ]
    }
  '';
}
