-- Uncomment to shut up LSP
-- https://github.com/L3MON4D3/LuaSnip/blob/8b25e74761eead3dc47ce04b5e017fd23da7ad7e/lua/luasnip/config.lua#L122-L147
-- local ls = require("luasnip")
-- local s = ls.snippet
-- local t = ls.text_node
-- local i = ls.insert_node
-- local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

return {
    s({ trig = "der", name = "derive" }, {
        t("#[derive("),
        i(1),
        t(")]"),
    }),

    s(
        { trig = "modt", name = "tests module" },
        fmt(
            [[
            #[cfg(test)]
            mod tests {{
              use super::*;
              {cursor}
            }}
            ]],
            { cursor = i(0) }
        )
    ),

    s({ trig = "uprel", name = "use prelude" }, {
        t("use "),
        i(1),
        t("::prelude::*;"),
    }),
}
