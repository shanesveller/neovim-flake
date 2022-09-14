-- vim: foldmethod=marker

local g = vim.g
local o = vim.opt

---- Disable builtins {{{

g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1

g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1

g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0

---- }}}

---- Early-stage keybinds {{{

g.mapleader = " "
g.maplocalleader = " "

---- }}}

---- Appearance {{{

-- Line numbering
o.number = true
o.relativenumber = true

-- Use single statusbar per window
o.laststatus = 3

vim.cmd.colorscheme("base16-tomorrow-night")

require("lualine").setup({
	options = {
		theme = "base16",
	},
})

---- }}}

---- Completion {{{

local lspkind = require("lspkind")

require("cmp").setup({
	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 5 },
	},

	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
			},
		}),
	},

	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})

---- }}}

---- Editing {{{

-- Indentation
o.shiftwidth = 2
o.smartindent = true
o.softtabstop = 2
o.tabstop = 2

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

---- }}}

---- Finder {{{

local tel = require("telescope")

tel.load_extension("fzf")
tel.load_extension("project")

tel.setup({
	defaults = {
		path_display = { shorten = 3 },
		preview = { hide_on_startup = true },
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		project = {
			base_dirs = {
				"~/.dotfiles",
				"~/src",
			},
			theme = "dropdown",
		},
	},
})

---- }}}

---- Keybinds {{{

local wk = require("which-key")
wk.setup({})

wk.register({
	["<leader>"] = {
		["'"] = { "<cmd>Telescope resume<CR>", "Resume last search" },
		b = {
			name = "Buffers",
			b = { "<cmd>buffers<CR>", "List" },
			B = { "<cmd>Telescope buffers<CR>", "List" },
			d = { "<cmd>bd<CR>", "Delete" },
			D = { "<cmd>%bd<CR>", "Delete All" },
			r = { "<cmd>edit<CR>", "Revert" },
		},
		f = {
			name = "Find/Files",
			["."] = { "<cmd>Telescope find_files cwd=%:h<CR>", "Find files" },
			f = { "<cmd>Telescope find_files<CR>", "Find files" },
			s = { "<cmd>write<CR>", "Save" },
			x = {
				function()
					vim.cmd.write()
					vim.cmd.source("%")
				end,
				"Save and source",
			},
		},
		l = {
			name = "LSP",
			i = { "<cmd>LspInfo<CR>", "Info" },
			L = { "<cmd>LspLog<CR>", "Log" },
			R = { "<cmd>LspRestart<CR>", "Restart" },
			s = { "<cmd>LspStart<CR>", "Start" },
			S = { "<cmd>LspStop<CR>", "Stop" },
		},
		p = {
			name = "Projects",
			f = { "<cmd>Telescope git_files<CR>", "Find project files" },
			p = { "<cmd>Telescope project<CR>", "Find project" },
		},
		s = {
			name = "Search",
			d = { "<cmd>Telescope live_grep cwd=%:h<CR>", "Search current directory" },
			p = { "<cmd>Telescope live_grep<CR>", "Search project" },
		},
		t = {
			name = "Telescope",
			g = { "<cmd>Telescope git_status<CR>", "Git Status" },
			h = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
			t = { "<cmd>Telescope<CR>", "Telescope" },
		},
		w = {
			name = "Windows",
			d = { "<cmd>close<CR>", "Close" },
			h = { "<cmd>wincmd h<CR>", "Left" },
			H = { "<cmd>wincmd H<CR>", "Left" },
			j = { "<cmd>wincmd j<CR>", "Down" },
			J = { "<cmd>wincmd J<CR>", "Down" },
			k = { "<cmd>wincmd k<CR>", "Up" },
			K = { "<cmd>wincmd K<CR>", "Up" },
			l = { "<cmd>wincmd l<CR>", "Right" },
			L = { "<cmd>wincmd L<CR>", "Right" },
		},
	},
})

---- }}}

---- LSP {{{

local lspconfig = require("lspconfig")
local luadev = require("lua-dev").setup({})
lspconfig.sumneko_lua.setup(luadev)

require("null-ls").setup({})

---- }}}

---- Syntax highlighting {{{

require("nvim-treesitter.configs").setup({
	auto_install = false,
	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = { enable = true },
	textobjects = { enable = true },
})

---- }}}
