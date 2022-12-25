return {
    {
        "mhanberg/elixir.nvim",
        config = function()
            require("elixir").setup({
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                cmd = { "elixir-ls" },
                on_attach = function(client, bufnr)
                    require("nvim-navic").attach(client, bufnr)

                    vim.keymap.set("n", "<localleader>mdg", "<cmd>Mix deps.get<CR>", { buffer = true })
                    vim.keymap.set("n", "<localleader>mp", "<cmd>ElixirToPipe<CR>", { buffer = true })
                    vim.keymap.set("n", "<localleader>mP", "<cmd>ElixirFromPipe<CR>", { buffer = true })
                end,
            })
        end,
        ft = "elixir",
    },
    { "mattn/emmet-vim", enabled = false },
    {
        "nvchad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({})
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({
                render = "background",
                enable_tailwind = true,
            })
        end,
    },
    { "tpope/vim-projectionist", ft = "elixir" },
    {
        "niklasl/vim-rdf",
        ft = "turtle",
        init = function()
            vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
                pattern = "*.ttl",
                callback = function()
                    vim.cmd.setfiletype("turtle")
                end,
            })
        end,
        config = function()
            require("Comment.ft").set("turtle", "# %s")
        end,
    },
}
