return {
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        cmd = "Neorg",
        ft = "norg",
        config = function()
            -- Must be after tree-sitter
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.export"] = {},
                    ["core.export.markdown"] = {
                        config = {
                            extensions = { "metadata" },
                            metadata = {
                                start = "<!--",
                                ["end"] = "-->",
                            },
                        },
                    },
                    ["core.integrations.telescope"] = {},
                    ["core.integrations.treesitter"] = {
                        config = {
                            install_parsers = true,
                        },
                    },
                },
            })
        end,
        dependencies = { "nvim-neorg/neorg-telescope" },
    },
}
