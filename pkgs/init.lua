-- vim: foldmethod=marker

local o = vim.opt

---- Editing {{{

-- Indentation
o.shiftwidth = 2
o.smartindent = true
o.softtabstop = 2
o.tabstop = 2

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
