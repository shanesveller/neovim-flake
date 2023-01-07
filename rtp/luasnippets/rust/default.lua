---@diagnostic disable:undefined-global

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
