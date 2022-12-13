vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "norg" },
    group = vim.api.nvim_create_augroup("NeorgLazyLoad", { clear = true }),
    callback = function()
        vim.api.nvim_del_augroup_by_name("NeorgLazyLoad")

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
                        install_parsers = false,
                    },
                },
            },
        })
    end,
})
