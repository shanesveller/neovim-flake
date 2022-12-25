return {
    {
        "saecki/crates.nvim",
        ft = "toml",
        init = function()
            vim.api.nvim_create_autocmd("BufRead", {
                group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
                pattern = "Cargo.toml",
                callback = function()
                    require("cmp").setup.buffer({ sources = { { name = "crates" } } })
                end,
            })
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = function()
            local rt = require("rust-tools")

            rt.setup({
                server = {
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    on_attach = function(client, bufnr)
                        require("nvim-navic").attach(client, bufnr)
                    end,
                },
            })
        end,
    },
    {
        "NoahTheDuke/vim-just",
        ft = "just",
        init = function()
            vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
                pattern = { ".justfile", "justfile" },
                callback = function()
                    vim.cmd.setfiletype("just")
                end,
            })
        end,
    },
}
