-- Uncomment to shut up LSP
-- https://github.com/L3MON4D3/LuaSnip/blob/8b25e74761eead3dc47ce04b5e017fd23da7ad7e/lua/luasnip/config.lua#L122-L147
-- local ls = require("luasnip")
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

return {
    s({ trig = "dsc", name = "describe block" }, {
        t('describe "'),
        i(1),
        t({ '" do', "  " }),
        i(0),
        t({ "", "end" }),
    }),
    s({ trig = "tst", name = "test block" }, {
        c(1, {
            sn(nil, {
                t('test "'),
                i(1, "description"),
                t('"'),
            }),
            sn(nil, {
                t('test "'),
                i(1, "description"),
                t({ '" do', "  ", "end" }),
            }),
        }),
    }),
}
