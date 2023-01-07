---@diagnostic disable:undefined-global

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
