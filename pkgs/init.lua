-- vim: foldmethod=marker

local o = vim.opt

---- Appearance {{{

-- Line numbering
o.number = true
o.relativenumber = true

-- Use single statusbar per window
o.laststatus = 3

vim.cmd.colorscheme("base16-tomorrow-night")

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
