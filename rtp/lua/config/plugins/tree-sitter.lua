return {
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        event = "BufReadPost",
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = false,
                sync_install = false,
                ensure_installed = {
                    "css",
                    "dockerfile",
                    "eex",
                    "elixir",
                    "embedded_template",
                    "fish",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "graphql",
                    "hcl",
                    "heex",
                    "help",
                    "html",
                    "javascript",
                    "json",
                    "jsonc",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "mermaid",
                    "nix",
                    -- Installed via `Neorg sync-grammars` instead
                    -- "norg",
                    "query",
                    "regex",
                    "rust",
                    "scss",
                    "toml",
                    "vim",
                    "wgsl",
                    "yaml",
                },
                highlight = {
                    enable = true,
                    disable = {},
                    additional_vim_regex_highlighting = false,
                },
                ignore_install = {},
                indent = { enable = true },
                incremental_selection = { enable = true },
                textobjects = {
                    enable = true,
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                },
            })

            -- Fold using tree-sitter grammar
            -- vim.o.foldenable = false
            -- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
            -- vim.o.foldlevelstart = 20
            -- vim.o.foldlevel = 20
            -- vim.o.foldmethod = "expr"

            -- local group = api.nvim_create_augroup("OpenFolds", { clear = true })
            -- api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
            -- 	group = group,
            -- 	pattern = "*",
            -- 	callback = function()
            -- 		vim.cmd.normal("zR")
            -- 	end,
            -- })
        end,
    },
}
