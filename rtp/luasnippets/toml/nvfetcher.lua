-- Uncomment to shut up LSP
-- https://github.com/L3MON4D3/LuaSnip/blob/8b25e74761eead3dc47ce04b5e017fd23da7ad7e/lua/luasnip/config.lua#L122-L147
-- local ls = require("luasnip")
-- local s = ls.snippet
-- local t = ls.text_node
-- local i = ls.insert_node
-- local rep = require("luasnip.extras").rep
-- local fmt = require("luasnip.extras.fmt").fmt

return {
    s(
        { trig = "nvf", name = "nvfetcher repo" },
        fmt(
            [[
            [{key}],
            src.git = "{url}"
            fetch.github = "{shortUrl}"
            {cursor}
            ]],
            {
                key = i(3),
                url = i(1),
                shortUrl = i(2),
                cursor = i(0),
            }
        )
    ),
}
