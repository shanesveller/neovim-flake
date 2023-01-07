return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "arkav/lualine-lsp-progress",
            "smiteshp/nvim-navic",
        },
        event = "VeryLazy",
        config = function()
            local navic = require("nvim-navic")

            require("lualine").setup({
                extensions = { "fugitive", "nvim-tree", "quickfix" },
                options = {
                    theme = "base16",
                },
                sections = {
                    lualine_c = {
                        "filename",
                        {
                            "lsp_progress",
                            display_components = {
                                "lsp_client_name",
                                "spinner",
                                "percentage",
                            },
                        },
                    },
                },
                winbar = {
                    lualine_c = {
                        { navic.get_location, cond = navic.is_available },
                    },
                    lualine_z = {},
                },
            })
        end,
    },
    {
        "smiteshp/nvim-navic",
        -- Credit: https://github.com/folke/LazyVim/blob/ce322b70420f1b0ec94bfab0d2fb6d104875b5e6/lua/lazyvim/plugins/ui.lua#L344-L348
        init = function()
            require("user.util").on_attach(function(client, buffer)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, buffer)
                end
            end)
        end,
        config = true,
    },
}
