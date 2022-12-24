require("persistence").setup({})

---- Keybinds {{{
-- All straight from README for now

-- restore the session for the current directory
vim.api.nvim_set_keymap(
    "n",
    "<leader>qs",
    [[<cmd>lua require("persistence").load()<cr>]],
    { desc = "persistence.nvim: restore local session" }
)

-- restore the last session
vim.api.nvim_set_keymap(
    "n",
    "<leader>ql",
    [[<cmd>lua require("persistence").load({ last = true })<cr>]],
    { desc = "persistence.nvim: restore last session" }
)

-- stop Persistence => session won't be saved on exit
vim.api.nvim_set_keymap(
    "n",
    "<leader>qd",
    [[<cmd>lua require("persistence").stop()<cr>]],
    { desc = "persistence.nvim: don't save current session" }
)
---- Keybinds }}}
