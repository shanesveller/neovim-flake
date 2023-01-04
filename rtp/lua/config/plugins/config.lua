return {
    { "direnv/direnv.vim", event = "BufReadPre" },
    {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        config = {
            import = {
                vscode = false,
                coc = false,
            },
        },
    },
}
