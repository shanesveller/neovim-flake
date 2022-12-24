local luasnip = require("luasnip")

local load_all = function()
    -- import friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load({
        exclude = { "elixir", "eelixir" },
    })

    if vim.env.DEV_SNIPPETS ~= nil then
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { vim.env.DEV_SNIPPETS },
        })
    else
        -- import local snippets
        require("luasnip.loaders.from_lua").lazy_load()
    end
end

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

vim.keymap.set("n", "<leader>oS", function()
    luasnip.cleanup()
    load_all()
    vim.notify_once("snippets cleared and reloaded")
end)

-- Keymaps }}}

load_all()

-- vim: foldmethod=marker
