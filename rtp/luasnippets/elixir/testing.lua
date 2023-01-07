---@diagnostic disable:undefined-global

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
