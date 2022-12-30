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
}
