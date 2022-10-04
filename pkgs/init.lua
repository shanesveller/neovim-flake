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

g.completeopt = "menu,menuone,noinsert"
g.spell = true
g.spell_lang = { "en_us" }

local lspkind = require("lspkind")

---- Cmp {{{

local cmp = require("cmp")
cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "path" },
    }, {
        { name = "buffer", keyword_length = 5 },
    }),

    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),

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

---- Command line {{{

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

for _, key in ipairs({ "/", "?" }) do
    cmp.setup.cmdline(key, {
        sources = {
            { name = "nvim_lsp_document_symbol" },
            { name = "buffer" },
        },
    })
end

---- File types {{{

cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "cmp_git" },
        { name = "spell" },
    }, {
        { name = "buffer" },
    }),
})

---- }}}

---- }}}

---- }}}

---- }}}

---- Editing {{{

-- Access system clipboard
o.clipboard = "unnamedplus"

-- Alignment
require("mini.align").setup({})

-- Comments
require("Comment").setup({})

-- Folding {{{

-- -- Fold using tree-sitter grammar
-- o.foldexpr = "nvim_treesitter#foldexpr()"
-- o.foldlevel = 20
-- o.foldmethod = "expr"

-- require("pretty-fold").setup({
-- 	global = {},
-- 	marker = { process_comment_signs = "spaces" },
-- 	expr = { process_comment_signs = false },
-- })

-- local group = api.nvim_create_augroup("OpenFolds", { clear = true })
-- api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
-- 	group = group,
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd.normal("zR")
-- 	end,
-- })

-- }}}

-- Highlight word under cursor
require("mini.cursorword").setup({})

-- Indentation
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.softtabstop = 2
o.tabstop = 2

require("indent_blankline").setup({})

-- Pairs
require("mini.pairs").setup({})

-- Scrolling
o.scrolloff = 8
o.sidescrolloff = 8

-- Search
o.ignorecase = true
o.smartcase = true

-- Surround
require("mini.surround").setup({})

---- }}}

---- File Tree {{{

local nvim_tree_lazy = function()
    require("nvim-web-devicons").setup({})
    require("nvim-tree").setup({})
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim tree" })
    vim.cmd("NvimTreeToggle")
end

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

vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
    callback = function()
        vim.fn.system("git rev-parse " .. vim.fn.expand("%:p:h"))
        if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
            vim.schedule(function()
                require("gitsigns").setup({})
            end)
        end
    end,
})

---- }}}

---- Keybinds {{{

local wk = require("which-key")
wk.setup({})

wk.register({
    ["<leader>"] = {
        ["'"] = { "<cmd>Telescope resume<CR>", "Resume last search" },
        [","] = { "<cmd>Telescope buffers<CR>", "List buffers" },
        ["`"] = { "<cmd>buffer #<CR>", "Switch to alternate buffer" },
        b = {
            name = "Buffers",
            b = { "<cmd>buffers<CR>", "List" },
            B = { "<cmd>Telescope buffers<CR>", "List" },
            d = { "<cmd>bd<CR>", "Delete" },
            D = { "<cmd>%bd<CR>", "Delete All" },
            r = { "<cmd>edit!<CR>", "Revert" },
        },
        e = { nvim_tree_lazy, "nvim-tree.lua" },
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
        o = {
            name = "Open",
            d = { "<cmd>Telescope git_files cwd=~/.dotfiles show_untracked=true<CR>", "Dotfiles" },
            v = { "<cmd>Telescope git_files cwd=~/src/neovim-flake show_untracked=true<CR>", "Neovim" },
        },
        p = {
            name = "Projects",
            f = { "<cmd>Telescope git_files show_untracked=true<CR>", "Find project files" },
            p = { "<cmd>lua require('telescope').extensions.project.project({})<CR>", "Find project" },
        },
        s = {
            name = "Search",
            d = { "<cmd>Telescope live_grep cwd=%:h<CR>", "Search current directory" },
            p = { "<cmd>Telescope live_grep<CR>", "Search project" },
            s = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Search current buffer" },
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

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "help", "man", "qf" },
    callback = function()
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
        vim.bo.buflisted = false
    end,
})

---- }}}

---- Knowledge/Documents {{{

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "norg" },
    group = vim.api.nvim_create_augroup("NeorgLazyLoad", { clear = true }),
    callback = function()
        vim.api.nvim_del_augroup_by_name("NeorgLazyLoad")

        -- Must be after tree-sitter
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.integrations.treesitter"] = {
                    config = {
                        install_parsers = false,
                    },
                },
            },
        })
    end,
})

---- }}}

---- LSP {{{

local lspconfig = require("lspconfig")

---- Keymap {{{
local on_attach_keymaps = function(_, bufnr)
    wk.register({
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

require("fidget").setup({})

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

---- Windows and Tabs {{{

o.splitbelow = true
o.splitright = true

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

-- Elixir {{{

require("elixir").setup({
    cmd = { "elixir-ls" },
})

-- }}}

-- Lua {{{

local luadev = require("lua-dev").setup({})
lspconfig.sumneko_lua.setup(luadev)

-- }}}

-- Nix {{{

lspconfig.nil_ls.setup({})

-- }}}

-- Rust {{{

local rt = require("rust-tools")

rt.setup({
    server = {},
})

-- }}}

---- }}}
