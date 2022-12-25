return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-project.nvim",
        },
        event = "User VeryLazy",
        config = function()
            local tel = require("telescope")
            local trouble = require("trouble.providers.telescope")

            tel.setup({
                defaults = {
                    mappings = {
                        i = { ["<c-t>"] = trouble.open_with_trouble },
                        n = { ["<c-t>"] = trouble.open_with_trouble },
                    },
                    path_display = { shorten = 3 },
                    preview = { hide_on_startup = true },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    project = {
                        base_dirs = {
                            "~/.dotfiles",
                            "~/src",
                        },
                        theme = "dropdown",
                    },
                },
            })
            tel.load_extension("fzf")
            tel.load_extension("project")
        end,
    },
}
