return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { { "nvim-tree/nvim-web-devicons", config = true } },
        config = true,
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle nvim tree" },
            { "<leader>E", "<cmd>NvimTreeFindFile<CR>", desc = "Open nvim tree to current file" },
        },
    },
}
