-- Appearance {{{

-- No search highlight
vim.o.hlsearch = false

-- Line numbering
vim.o.number = true
vim.o.relativenumber = true

-- Use single statusbar per window
vim.o.laststatus = 3

-- Appearance }}}

-- Completion {{{

vim.g.completeopt = "menu,menuone,noinsert"
vim.g.spell = true
vim.g.spell_lang = { "en_us" }

-- Completion }}}

-- Editing {{{

-- Access system clipboard
vim.o.clipboard = "unnamedplus"

-- Indentation
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- Scrolling
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Editing }}}

-- Prevent file cruft
vim.o.backup = false
vim.o.swapfile = false

-- Windows and Tabs {{{

vim.o.splitbelow = true
vim.o.splitright = true

-- Windows and Tabs }}}

return {}
