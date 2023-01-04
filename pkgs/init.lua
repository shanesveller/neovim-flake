-- vim: foldmethod=marker

local api = vim.api
local g = vim.g
local o = vim.opt

local configdir = vim.fs.normalize("~/src/neovim-flake")

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

-- Required for vim-rhubarb :GBrowse
-- g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0

g.loaded_remote_plugins = 1
g.loaded_spellfile_plugin = 1
g.loaded_tutor_mode_plugin = 1

-- Prevent file cruft
o.backup = false
o.swapfile = false

---- }}}

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

---- Statusline {{{

local navic = require("nvim-navic")

---- Statusline }}}

---- }}}

---- Completion {{{

g.completeopt = "menu,menuone,noinsert"
g.spell = true
g.spell_lang = { "en_us" }

require("user.plugins.cmp")

---- }}}

---- Configuration {{{
require("neoconf").setup({
    import = {
        vscode = false,
        coc = false,
    },
})
---- Configuration }}}

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

---- LSP {{{

local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

---- Keymap {{{
local on_attach_keymaps = function(_, bufnr)
    require("which-key").register({
        g = {
            d = { vim.lsp.buf.definition, "Definition" },
            D = { vim.lsp.buf.declaration, "Declaration" },
            i = { vim.lsp.buf.implementation, "Go to Implementation" },
            l = { vim.diagnostic.open_float, "Open Diagnostic Float" },
            r = { vim.lsp.buf.references, "Symbol References" },
        },
        K = { vim.lsp.buf.hover, "LSP Hover" },
        ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature Help" },
        ["[d"] = { vim.diagnostic.goto_prev, "Go to Next Diagnostic" },
        ["]d"] = { vim.diagnostic.goto_next, "Go to Previous Diagnostic" },
        ["<leader>"] = {
            ca = { vim.lsp.buf.code_action, "Code Action" },
            rn = { vim.lsp.buf.rename, "Rename Symbol" },
            lf = { "<cmd>Telescope lsp_document_symbols symbols=function<CR>", "LSP document functions" },
            lr = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename via LSP" },
            si = { "<cmd>Telescope lsp_document_symbols<CR>", "LSP document symbols" },
        },
    }, { buffer = bufnr })
end
---- }}}

---- Null-ls {{{
local augroup = api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        -- Elixir
        null_ls.builtins.diagnostics.credo,
        null_ls.builtins.formatting.mix,
        -- Git
        null_ls.builtins.code_actions.gitsigns,
        -- Lua
        null_ls.builtins.formatting.stylua,
        -- Nix
        null_ls.builtins.code_actions.statix,
        null_ls.builtins.diagnostics.statix,
        null_ls.builtins.formatting.alejandra,
        -- Rust
        null_ls.builtins.formatting.rustfmt,
    },

    on_attach = function(client, bufnr)
        on_attach_keymaps(client, bufnr)

        if client.supports_method("textDocument/formatting") then
            api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(this_client)
                            return this_client.name ~= "rnix" and this_client.name ~= "sumneko_lua"
                        end,
                    })
                end,
            })
        end
    end,
})
---- }}}

---- Winbar Context {{{

navic.setup({})

local navic_attach = function(client, bufnr)
    navic.attach(client, bufnr)
end

---- Winbar Context }}}

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

---- Languages {{{

-- CSS {{{
lspconfig.cssls.setup({
    capabilities = capabilities,
    on_attach = navic_attach,
})

lspconfig.tailwindcss.setup({
    capabilities = capabilities,
    -- TODO: navic reports error, but seems supported?
    -- https://github.com/tailwindlabs/tailwindcss-intellisense/blob/8fce24db9c480a9615e175fb3acaac91f7a0a7c1/packages/tailwindcss-intellisense/src/extension.ts#L168
    -- on_attach = navic_attach,
    init_options = {
        userLanguages = {
            elixir = "phoenix-heex",
            heex = "phoenix-heex",
        },
    },
    settings = {
        -- https://github.com/tailwindlabs/tailwindcss-intellisense/tree/6b3e598e5378812b42db8a208db4980c82b60a10/packages/vscode-tailwindcss#tailwindcssincludelanguages
        includeLanguages = {
            ["html-eex"] = "html",
            ["phoenix-heex"] = "html",
            eelixir = "html",
            heex = "html",
        },
        tailwindCSS = {
            emmetCompletions = true,
            experimental = {
                classRegex = {
                    [[class= "([^"]*)]],
                    [[class: "([^"]*)]],
                    '~H""".*class="([^"]*)".*"""',
                },
            },
            validate = true,
        },
    },
    filetypes = {
        "css",
        "elixir",
        "heex",
        "html",
        "html-eex",
    },
})
-- }}}

-- HTML {{{
lspconfig.html.setup({
    capabilities = capabilities,
    on_attach = navic_attach,
})
-- }}}

-- JavaScript/TypeScript {{{
lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = navic_attach,
})
-- }}}

-- JSON {{{
lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = navic_attach,
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})
-- }}}

-- Nix {{{

lspconfig.nil_ls.setup({
    capabilities = capabilities,
    on_attach = navic_attach,
})

-- }}}

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
