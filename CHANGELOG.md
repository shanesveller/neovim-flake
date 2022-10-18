<a name="2022-10-10"></a>
## 2022-10-10 (2022-10-18)


#### Features

* **completion:**
  *  Enable Git commit message completion ([8fb1b7f9](8fb1b7f9))
  *  Enable completion in Vim command line ([e88e174a](e88e174a))
  *  Tune core cmp keymap ([804116cb](804116cb))
  *  Install and configure cmp ([4d8b5472](4d8b5472))
* **editing:**
  *  Install indent-blankline.nvim ([6defb614](6defb614))
  *  Activate mini.surround ([058e4468](058e4468))
  *  Activate mini.pairs ([4e82062a](4e82062a))
  *  Activate mini.cursorword ([90d9f3c6](90d9f3c6))
  *  Activate mini.align ([5e6c3d5a](5e6c3d5a))
  *  Install mini.nvim ([44700df5](44700df5))
  *  Enable access to system clipboard ([7ed5a832](7ed5a832))
  *  Convert tabs to spaces ([a6bfcf76](a6bfcf76))
  *  Automatically scroll when cursor is near window boundaries ([39603088](39603088))
  *  Install pretty-fold.nvim ([74ee1390](74ee1390))
  *  Install and configure comment.nvim ([6e26ce42](6e26ce42))
  *  Automatically open folds when entering buffer ([b6bf2314](b6bf2314))
  *  Configure tree-sitter-based folding ([8f0003e4](8f0003e4))
  *  Install direnv support ([dd62cda2](dd62cda2))
  *  Configure default indentation behavior ([715c8db6](715c8db6))
* **editor:**
  *  Switch to Neovim 0.8.0 final ([a289b5aa](a289b5aa))
  *  Build wrapped Neovim config from upstream derivation ([8b36b6ab](8b36b6ab))
* **filebrowser:**  Install and configure nvim-tree ([f3d5bc57](f3d5bc57))
* **finder:**  Install and configure Telescope ([33bc7b11](33bc7b11))
* **git:**
  *  Install and configure Fugitive ([94ec7a4c](94ec7a4c))
  *  Install and configure gitsigns ([c91448e5](c91448e5))
* **keybinds:**
  *  Add keybind to search current document for LSP symbols ([eb7727aa](eb7727aa))
  *  Allow quitting popups with q ([34d95946](34d95946))
  *  Add keybinds for Telescope ([f0e79adf](f0e79adf))
  *  Add keybinds for window management ([114f791c](114f791c))
  *  Add keybinds for buffer management ([f95f151b](f95f151b))
  *  Add keybinds for file management ([b0a2d8e2](b0a2d8e2))
  *  Install and configure which-key ([a26ad030](a26ad030))
* **languages:**
  *  Install rust-tools.nvim ([fbbbcef8](fbbbcef8))
  *  Install vim-just ([dcb90bfa](dcb90bfa))
  *  Install and configure elixir.nvim ([119c4bf4](119c4bf4))
* **lsp:**
  *  Replace rnix with nil ([ca847163](ca847163))
  *  Install fidget.nvim ([ad43e7cc](ad43e7cc))
  *  Activate default rust-analyzer support ([a4cd2952](a4cd2952))
  *  Configure LSP support for Nix via rnix ([c9e883af](c9e883af))
  *  Enable Elixir formatting and diagnostics in null-ls ([1316ac28](1316ac28))
  *  Enable null-ls support for statix ([2b764aa7](2b764aa7))
  *  Add LSP-specific buffer-local keybinds ([f4e86271](f4e86271))
  *  Deactivate idle, empty LSP clients with grace period ([5a42fdc6](5a42fdc6))
  *  Configure formatting-on-save for null-ls ([fa38486e](fa38486e))
  *  Install and configure null-ls ([c871f752](c871f752))
  *  Configure Lua LSP support ([e0b25ed1](e0b25ed1))
* **neorg:**
  *  Install neorg telescope extension ([c26d047e](c26d047e))
  *  Install neorg ([50915d04](50915d04))
* **perf:**
  *  Lazy-load gitsigns ([11e985fb](11e985fb))
  *  Disable many Neovim builtins ([296954ed](296954ed))
* **theme:**
  *  Install and configure lualine ([7cbbf9d2](7cbbf9d2))
  *  Configure base16 theme ([5747ebb6](5747ebb6))
  *  Configure line numbering ([76552ade](76552ade))
  *  Configure single statusbar per window ([bd1ccd2f](bd1ccd2f))
* **tree-sitter:**
  *  Add grammars for Neorg ([6ac1024a](6ac1024a))
  *  Migrate out-of-tree tree-sitter grammars to nvfetcher ([8834aecd](8834aecd))
  *  Add tree-sitter grammar for Just ([7e4ff778](7e4ff778))
  *  Include local tree-sitter-eex in config ([9fa78acc](9fa78acc))
  *  Add local package for tree-sitter-eex ([b0a45bce](b0a45bce))
* **windows:**  Open splits to right/down from current ([846f5c69](846f5c69))
* **workflow:**
  *  Generate Nix fetchers for plugins ([f4a641ad](f4a641ad))
  *  Install vim-projectionist ([ff9fdd0e](ff9fdd0e))
* **workspace:**
  *  Add Just target to regenerate changelog ([4a431513](4a431513))
  *  Add just targets to run nvfetcher ([103bb2b9](103bb2b9))
  *  Pass in grammars via legacyPackages ([99115f91](99115f91))
  *  Use overlay and extend to provide local vimPlugins ([28555f1d](28555f1d))
  *  Convert to flake-parts ([75c9f099](75c9f099))
  *  Include Nix/Lua LSP binaries in devShell ([f30c1ae4](f30c1ae4))
  *  Install nvfetcher in devShell ([038a8c1d](038a8c1d))
  *  Add justfile for task automation ([849dc0f1](849dc0f1))
  *  Enable Nix-managed pre-commit hooks ([81af799c](81af799c))
  *  Expose local package for Neovim nightly ([9474d2e9](9474d2e9))
  *  Add flake input for Neovim upstream ([84a0ad42](84a0ad42))
  *  Create empty flake with flake-parts ([4c45e89f](4c45e89f))

#### Bug Fixes

* **editing:**  Leave Lua tabs as tabs for stylua ([32030eda](32030eda))
* **keybinds:**  Use correct command to unconditionally revert buffer ([9c18ad48](9c18ad48))
* **lsp:**  Don't set paths to LSP binaries inside config ([ae18e376](ae18e376))
* **workspace:**
  *  Disambiguate Nix function call syntax ([9e175e09](9e175e09))
  *  Use proper flake-parts URL instead of registry entry ([ef6873b0](ef6873b0))



