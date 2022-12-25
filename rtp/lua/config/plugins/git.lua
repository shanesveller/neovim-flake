return {
    "sindrets/diffview.nvim",
    { "tpope/vim-fugitive", lazy = false },
    {
        "lewis6991/gitsigns.nvim",
        init = function()
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.system("git rev-parse " .. vim.fn.expand("%:p:h"))
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
                        vim.schedule(function()
                            require("gitsigns").setup({})
                            require("diffview").setup({})
                        end)
                    end
                end,
            })
        end,
    },
    { "tpope/vim-rhubarb", cmd = { "GBrowse" }, keys = { "<leader>goo" } },
}
