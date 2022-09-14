-- vim: foldmethod=marker

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
