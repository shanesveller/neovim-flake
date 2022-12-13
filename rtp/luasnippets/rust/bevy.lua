-- Uncomment to shut up LSP
-- https://github.com/L3MON4D3/LuaSnip/blob/8b25e74761eead3dc47ce04b5e017fd23da7ad7e/lua/luasnip/config.lua#L122-L147
-- local ls = require("luasnip")
-- local s = ls.snippet
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep
return {
    s(
        { trig = "plugin", name = "new plugin unit struct" },
        fmt(
            [[
            #[derive(Clone, Copy, Debug)]
            pub struct {name};

            impl PluginGroup for {name} {{
                fn build(self) -> PluginGroupBuilder {{
                    PluginGroupBuilder::start::<Self>(){cursor}
                }}
            }}
            ]],
            {
                name = i(1, "SomePlugin"),
                cursor = i(0),
            },
            { repeat_duplicates = true }
        )
    ),

    s({ trig = "plugint", name = "test plugin unit struct" }, {
        t("use "),
        c(1, {
            t("bevy::prelude::App"),
            t("crate::test_helpers::test_app"),
        }),
        t({
            ";",
            "",
            "#[test]",
            "fn test_",
        }),
        i(2, "plugin"),
        t({ "() {" }),
        t({
            "",
            "    let mut app = ",
        }),
        i(3, "App::new();"),
        t({
            "    app.add_",
        }),
        c(4, {
            t("plugin("),
            t("plugins("),
        }),
        i(5),
        t({ ");", "    " }),
        i(0),
        t({
            "",
            "    app.update();",
        }),
        t({ "", "}" }),
    }),

    s({ trig = "usesys", name = "use statements for modules defining systems" }, {
        t({
            "use bevy::prelude::*;",
        }),
    }),
}
