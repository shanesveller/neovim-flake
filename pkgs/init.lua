-- vim: foldmethod=marker

local api = vim.api
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

-- Comments
require("Comment").setup({})

-- Folding {{{

-- Fold using tree-sitter grammar
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 20
o.foldmethod = "expr"

require("pretty-fold").setup({
	global = {},
	marker = { process_comment_signs = "spaces" },
	expr = { process_comment_signs = false },
})

local group = api.nvim_create_augroup("OpenFolds", { clear = true })
api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
	group = group,
	pattern = "*",
	callback = function()
		vim.cmd.normal("zR")
	end,
})

-- }}}

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

---- Git {{{

require("gitsigns").setup({})

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
		g = {
			name = "Git",
			["["] = { "<cmd>Gitsigns prev_hunk<CR>", "Previous hunk" },
			["]"] = { "<cmd>Gitsigns next_hunk<CR>", "Previous hunk" },
			A = { "<cmd>Git commit --amend --verbose<CR>", "Amend commit" },
			b = { "<cmd>Gitsigns blame_line<CR>", "Blame current line" },
			B = { "<cmd>Git blame<CR>", "Blame current file" },
			c = { "<cmd>Git commit --verbose<CR>", "Commit" },
			d = { "<cmd>Git diff<CR>", "Diff" },
			D = { "<cmd>Git diff --staged<CR>", "Diff Staged" },
			g = { "<cmd>Git<CR>", "Git Status" },
			s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
			S = { "<cmd>Gitsigns stage_buffer<CR>", "Stage file" },
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

local augroup = api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- Git
		null_ls.builtins.code_actions.gitsigns,
		-- Lua
		null_ls.builtins.formatting.stylua,
		-- Nix
		null_ls.builtins.formatting.alejandra,
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- Neovim 0.8+
					vim.lsp.buf.format({ bufnr = bufnr })
					-- Neovim 0.7
					-- vim.lsp.buf.formatting_seq_sync()
				end,
			})
		end
	end,
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

---- Local {{{

-- Time out disconnected, empty LSP clients
local timeout_augroup = api.nvim_create_augroup("LspTimeout", { clear = true })

local function delete_empty_lsp_clients()
	local clients = vim.lsp.get_active_clients()
	for _, client in ipairs(clients) do
		local bufs = vim.lsp.get_buffers_by_client_id(client.id)
		if #bufs == 0 then
			print("stopping LSP client " .. client.name)
			client:stop()
		end
	end
end

api.nvim_create_autocmd("BufDelete", {
	group = timeout_augroup,
	pattern = "*",
	callback = function()
		vim.defer_fn(delete_empty_lsp_clients, 5000)
	end,
})

---- }}}
