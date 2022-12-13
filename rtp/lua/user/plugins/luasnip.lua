local luasnip = require("luasnip")

-- Keymaps {{{

vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

vim.keymap.set("i", "<C-l>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end)

vim.keymap.set("n", "<leader>os", function()
    require("luasnip.loaders").edit_snippet_files()
end)

-- Keymaps }}}

-- import friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- vim: foldmethod=marker
