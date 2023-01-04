-- Time out disconnected, empty LSP clients
vim.api.nvim_create_autocmd("BufDelete", {
    group = vim.api.nvim_create_augroup("LspTimeout", { clear = true }),
    pattern = "*",
    callback = function()
        local delete_empty_lsp_clients = function()
            local clients = vim.lsp.get_active_clients()
            for _, client in ipairs(clients) do
                local bufs = vim.lsp.get_buffers_by_client_id(client.id)
                if #bufs == 0 then
                    print("stopping LSP client " .. client.name)
                    client:stop()
                end
            end
        end

        vim.defer_fn(delete_empty_lsp_clients, 5000)
    end,
})

return {
    "onsails/lspkind.nvim",
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        config = function()
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
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
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
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
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("user.plugins.lsp")
        end,
        ft = { "elixir", "lua", "rust" },
    },
}
