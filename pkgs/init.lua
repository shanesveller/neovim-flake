-- vim: foldmethod=marker

local api = vim.api
local g = vim.g

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

---- Highlight on Yank {{{

api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
})

---- Highlight on Yank }}}

---- Appearance }}}

---- Completion {{{

require("user.plugins.cmp")

---- }}}

---- Windows and Tabs {{{

-- Rebalance windows whenever Tmux/terminal resizes
api.nvim_create_autocmd("VimResized", {
    group = api.nvim_create_augroup("Window Rebalance", { clear = true }),
    pattern = "*",
    command = "wincmd =",
})

---- Windows and Tabs }}}

---- Deferred Loads {{{
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = function()
        require("user.config.keybinds")
    end,
})
---- Deferred Loads }}}
