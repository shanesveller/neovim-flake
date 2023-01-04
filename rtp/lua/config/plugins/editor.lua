return {
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "BufReadPost",
        config = true,
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        config = true,
        keys = {
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", "Trouble.nvim Document Diag" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", "Trouble.nvim Loclist" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", "Trouble.nvim Quickfix" },
            { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", "Trouble.nvim Workspace Diag" },
            { "<leader>xx", "<cmd>TroubleToggle<CR>", "Toggle Trouble.nvim" },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "InsertEnter",
        config = {
            char = "┊",
            show_trailing_blankline_indent = false,
        },
    },
    { "echasnovski/mini.nvim", enabled = false },
    {
        "echasnovski/mini.align",
        config = function()
            require("mini.align").setup({})
        end,
        event = "InsertEnter",
    },
    {
        "echasnovski/mini.cursorword",
        config = function()
            require("mini.cursorword").setup({})
        end,
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.pairs",
        config = function()
            require("mini.pairs").setup({})
        end,
        event = "InsertEnter",
    },
    {
        "echasnovski/mini.surround",
        config = function()
            require("mini.surround").setup({})
        end,
        event = "InsertEnter",
    },
    { "numtostr/comment.nvim", config = true, event = { "BufReadPost", "InsertEnter" } },
}
