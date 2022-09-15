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

---- Keybinds {{{

local wk = require("which-key")
wk.setup({})

wk.register({
	["<leader>"] = {
		b = {
			name = "Buffers",
			b = { "<cmd>buffers<CR>", "List" },
			d = { "<cmd>bd<CR>", "Delete" },
			D = { "<cmd>%bd<CR>", "Delete All" },
			r = { "<cmd>edit<CR>", "Revert" },
		},
		f = {
			name = "Files",
			s = { "<cmd>write<CR>", "Save" },
			x = {
				function()
					vim.cmd.write()
					vim.cmd.source("%")
				end,
				"Save and source",
			},
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
