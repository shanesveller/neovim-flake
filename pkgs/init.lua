-- vim: foldmethod=marker

local api = vim.api
local g = vim.g
local o = vim.opt

local configdir = vim.fs.normalize("~/src/neovim-flake")

---- Early-stage keybinds {{{

g.mapleader = " "
g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

---- }}}

---- Bootstrap lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
---- Bootstrap lazy.nvim }}}

---- Load plugins via Lazy.nvim {{{
require("lazy").setup("config.plugins", {
    defaults = { lazy = true },
    lockfile = configdir .. "/lazy-lock.json",
    install = { colorscheme = { "base16-tomorrow-night", "tokyonight", "habamax" } },
    checker = { enabled = false },
    ui = { border = "rounded" },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "logiPat",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "node_provider",
                "perl_provider",
                "python3_provider",
                "rrhelper",
                "ruby_provider",
                "tarPlugin",
                "tohtml",
                "tutor",
                "vimball",
                "zipPlugin",
            },
        },
    },
})
---- Load plugins via Lazy.nvim }}}

---- Appearance {{{

-- No search highlight
o.hlsearch = false

-- Line numbering
o.number = true
o.relativenumber = true

-- Use single statusbar per window
o.laststatus = 3

---- Highlight on Yank {{{

api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
})

---- Highlight on Yank }}}

---- }}}

---- Completion {{{

g.completeopt = "menu,menuone,noinsert"
g.spell = true
g.spell_lang = { "en_us" }

require("user.plugins.cmp")

---- }}}

---- Editing {{{

-- Access system clipboard
o.clipboard = "unnamedplus"

-- Indentation
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.softtabstop = 2
o.tabstop = 2

-- Scrolling
o.scrolloff = 8
o.sidescrolloff = 8

-- Search
o.ignorecase = true
o.smartcase = true

---- }}}

---- Windows and Tabs {{{

o.splitbelow = true
o.splitright = true

-- Rebalance windows whenever Tmux/terminal resizes
api.nvim_create_autocmd("VimResized", {
    group = api.nvim_create_augroup("Window Rebalance", { clear = true }),
    pattern = "*",
    command = "wincmd =",
})

---- }}}

---- Deferred Loads {{{
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = function()
        require("user.config.keybinds")
    end,
})
---- Deferred Loads }}}
