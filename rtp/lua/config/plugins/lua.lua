return {
    {
        "folke/neodev.nvim",
        config = {
            override = function(root_dir, library)
                if require("neodev.util").has_file(root_dir, "~/src/neovim-flake") then
                    library.enabled = true
                    library.plugins = true
                end
            end,
        },
    },
}
