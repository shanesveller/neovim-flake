return {
    {
        "folke/neodev.nvim",
        ft = "lua",
        config = function()
            require("neodev").setup({
                override = function(root_dir, library)
                    if require("neodev.util").has_file(root_dir, "~/src/neovim-flake") then
                        library.enabled = true
                        library.plugins = true
                    end
                end,
            })

            require("lspconfig").sumneko_lua.setup({
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                on_attach = function(client, bufnr)
                    require("nvim-navic").attach(client, bufnr)
                end,
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
        end,
    },
}
