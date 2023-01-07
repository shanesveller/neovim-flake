---@diagnostic disable:undefined-global

local fname = function(args)
    local name = args[1][1]
    local split = vim.split(name, " ", { trimempty = true })

    return table.concat(split, " ", 1, #split - 1)
end

local sname = function(args)
    local name = args[1][1]
    local split = vim.split(name, " ", { trimempty = true })

    return split[#split]
end

return {
    s(
        "chapter",
        fmt(
            [[
            chapters:{number}
              chapter:chapterOf book:{book}
              ; chapter:title "{title}"
              ; chapter:icon icons:{icon}
              .
            ]],
            {
                number = i(1),
                book = i(2),
                title = i(3, "title"),
                icon = i(4, "icon"),
            }
        )
    ),
    s(
        "newchap",
        fmt(
            [[
            @base <https://rdf.fantasygeek.app/> .

            @prefix : <https://rdf.fantasygeek.app/unknown#> .
            @prefix cal: <calendar#> .
            @prefix char: <characters/> .
            @prefix chapter: <books/1/chapters/> .
            @prefix gr: <groups/> .
            @prefix loc: <location/> .
            @prefix op: <channeling/> .
            @prefix prophecy: <prophecy/> .
            @prefix quote: <quote/> .

            @prefix foaf: <http://xmlns.com/foaf/0.1/> .
            @prefix rel: <http://www.perceive.net/schemas/relationship/> .
            @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

            # Chapter {chap}
            ]],
            { chap = i(1) }
        )
    ),
    s(
        "closechap",
        fmt(
            [[
            chapter:{chap}
              a :Chapter
              ; chapter:pov char:{char}
              ; chapter:setting loc:{loc}
              ; :depicts char:{char}
              {cursor}
            ]],
            {
                chap = i(1),
                char = i(2),
                cursor = c(4, {
                    t({ "; :mentions char:", "  .", "" }),
                    t({ ".", "" }),
                    t("; "),
                }),
                loc = i(3),
            }
        )
    ),
    s(
        "newchar",
        fmt(
            [[
            char:{id}
              a foaf:Person
              ; foaf:name "{name}"
              ; foaf:firstName "{fname}"
              ; foaf:surname "{surname}"
              {cursor}
            ]],
            {
                id = i(1),
                name = i(2),
                fname = f(fname, { 2 }),
                surname = f(sname, { 2 }),
                cursor = c(3, {
                    t({ ".", "" }),
                    t(";"),
                }),
            }
        )
    ),
}
