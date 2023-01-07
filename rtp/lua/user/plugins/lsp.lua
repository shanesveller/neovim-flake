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

require("user.util").on_attach(function(client, buffer)
    on_attach_keymaps(client, buffer)
end)

---- }}}

---- }}}

---- Languages {{{

-- CSS {{{
lspconfig.cssls.setup({
    capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
    capabilities = capabilities,
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
})
-- }}}

-- JavaScript/TypeScript {{{
lspconfig.eslint.setup({
    capabilities = capabilities,
})
-- }}}

-- JSON {{{
lspconfig.jsonls.setup({
    capabilities = capabilities,
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})
-- }}}

-- Lua {{{
lspconfig.sumneko_lua.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
            telemetry = { enable = false },
            workspace = {
                checkThirdParty = false,
                ignoreDir = { ".direnv", "result" },
            },
        },
    },
})
-- Lua }}}

-- Nix {{{

lspconfig.nil_ls.setup({
    capabilities = capabilities,
})

-- }}}
