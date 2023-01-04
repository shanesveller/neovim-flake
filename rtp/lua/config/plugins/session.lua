return {
    {
        "folke/persistence.nvim",
        config = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
        lazy = false,
        keys = {
            {
                "<leader>qs",
                function()
                    require("persistence").load()
                end,
                desc = "Restore Session",
            },
            {
                "<leader>ql",
                function()
                    require("persistence").load({ last = true })
                end,
                desc = "Restore Last Session",
            },
            {
                "<leader>qd",
                function()
                    require("persistence").stop()
                end,
                desc = "Delete Current Session",
            },
        },
    },
}
