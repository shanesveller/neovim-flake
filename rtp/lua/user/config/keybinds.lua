local wk = require("which-key")
wk.setup({})

wk.register({
    gR = { "<cmd>TroubleToggle lsp_references<CR>", "Trouble.nvim LSP Refs" },
    ["<leader>"] = {
        ["'"] = { "<cmd>Telescope resume<CR>", "Resume last search" },
        [","] = { "<cmd>Telescope buffers<CR>", "List buffers" },
        ["`"] = { "<cmd>buffer #<CR>", "Switch to alternate buffer" },
        b = {
            name = "Buffers",
            b = { "<cmd>buffers<CR>", "List" },
            B = { "<cmd>Telescope buffers<CR>", "List" },
            d = { "<cmd>bd<CR>", "Delete" },
            D = { "<cmd>%bd<CR>", "Delete All" },
            r = { "<cmd>edit!<CR>", "Revert" },
        },
        f = {
            name = "Find/Files",
            ["."] = { "<cmd>Telescope find_files cwd=%:h<CR>", "Find files" },
            f = { "<cmd>Telescope find_files<CR>", "Find files" },
            s = { "<cmd>write<CR>", "Save" },
            x = {
                function()
                    vim.cmd.write()
                    vim.cmd.source("%")
                end,
                "Save and source",
            },
        },
        g = {
            name = "Git",
            ["["] = { "<cmd>Gitsigns prev_hunk<CR>", "Previous hunk" },
            ["]"] = { "<cmd>Gitsigns next_hunk<CR>", "Previous hunk" },
            A = { "<cmd>Git commit --amend --verbose<CR>", "Amend commit" },
            b = { "<cmd>Gitsigns blame_line<CR>", "Blame current line" },
            B = { "<cmd>Git blame<CR>", "Blame current file" },
            c = { "<cmd>Git commit --verbose<CR>", "Commit" },
            d = { "<cmd>Git diff<CR>", "Diff" },
            D = { "<cmd>Git diff --staged<CR>", "Diff Staged" },
            g = { "<cmd>Git<CR>", "Git Status" },
            s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
            S = { "<cmd>Gitsigns stage_buffer<CR>", "Stage file" },
            x = {
                function()
                    vim.api.nvim_feedkeys(":G absorb -b=", "n", true)
                end,
                "Git Absorb",
            },
        },
        go = {
            name = "Git Open",
            o = { vim.cmd.GBrowse, "Browse at GitHub" },
        },
        l = {
            name = "LSP",
            d = {
                function()
                    for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
                        vim.lsp.buf_detach_client(0, client.id)
                    end
                end,
                "Detach",
            },
            i = { "<cmd>LspInfo<CR>", "Info" },
            l = { "<cmd>Lazy<CR>", "Lazy.nvim" },
            L = { "<cmd>LspLog<CR>", "Log" },
            R = { "<cmd>LspRestart<CR>", "Restart" },
            s = { "<cmd>LspStart<CR>", "Start" },
            S = { "<cmd>LspStop<CR>", "Stop" },
        },
        o = {
            name = "Open",
            d = { "<cmd>Telescope git_files cwd=~/.dotfiles show_untracked=true<CR>", "Dotfiles" },
            v = { "<cmd>Telescope git_files cwd=~/src/neovim-flake show_untracked=true<CR>", "Neovim" },
        },
        p = {
            name = "Projects",
            f = { "<cmd>Telescope git_files show_untracked=true<CR>", "Find project files" },
            p = { "<cmd>lua require('telescope').extensions.project.project({})<CR>", "Find project" },
        },
        s = {
            name = "Search",
            d = { "<cmd>Telescope live_grep cwd=%:h<CR>", "Search current directory" },
            p = { "<cmd>Telescope live_grep<CR>", "Search project" },
            s = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Search current buffer" },
        },
        t = {
            name = "Telescope",
            g = { "<cmd>Telescope git_status<CR>", "Git Status" },
            h = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
            t = { "<cmd>Telescope<CR>", "Telescope" },
        },
        w = {
            name = "Windows",
            d = { "<cmd>close<CR>", "Close" },
            h = { "<cmd>wincmd h<CR>", "Left" },
            H = { "<cmd>wincmd H<CR>", "Left" },
            j = { "<cmd>wincmd j<CR>", "Down" },
            J = { "<cmd>wincmd J<CR>", "Down" },
            k = { "<cmd>wincmd k<CR>", "Up" },
            K = { "<cmd>wincmd K<CR>", "Up" },
            l = { "<cmd>wincmd l<CR>", "Right" },
            L = { "<cmd>wincmd L<CR>", "Right" },
        },
        x = {
            name = "Trouble",
            d = { "<cmd>TroubleToggle document_diagnostics<CR>", "Trouble.nvim Document Diag" },
            l = { "<cmd>TroubleToggle loclist<CR>", "Trouble.nvim Loclist" },
            q = { "<cmd>TroubleToggle quickfix<CR>", "Trouble.nvim Quickfix" },
            w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Trouble.nvim Workspace Diag" },
            x = { "<cmd>TroubleToggle<CR>", "Toggle Trouble.nvim" },
        },
    },
})

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "fugitive", "help", "man", "qf" },
    callback = function()
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
        vim.bo.buflisted = false
    end,
})
