---@diagnostic disable:undefined-global

return {
    s({ trig = "section", name = "config section" }, {
        t("---- "),
        i(1),
        t({ " {{{", "" }),
        i(0),
        t({ "", "---- " }),
        rep(1),
        t(" }}}"),
    }),
    s({ trig = "luasnipreq", name = "luasnip heading" }, {
        t({
            "-- Uncomment to shut up LSP",
            "-- https://github.com/L3MON4D3/LuaSnip/blob/8b25e74761eead3dc47ce04b5e017fd23da7ad7e/lua/luasnip/config.lua#L122-L147",
            'local ls = require("luasnip")',
            "local s = ls.snippet",
            "local t = ls.text_node",
            "local i = ls.insert_node",
            'local rep = require("luasnip.extras").rep',
        }),
        i(0),
    }),
}
