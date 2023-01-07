---- Highlight on Yank {{{
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
})
---- Highlight on Yank }}}

---- Rebalance windows whenever Tmux/terminal resizes {{{
vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup("Window Rebalance", { clear = true }),
    pattern = "*",
    command = "wincmd =",
})
---- Rebalance windows whenever Tmux/terminal resizes }}}

---- Time out disconnected, empty LSP clients {{{
vim.api.nvim_create_autocmd("BufDelete", {
    group = vim.api.nvim_create_augroup("LspTimeout", { clear = true }),
    pattern = "*",
    callback = function()
        local delete_empty_lsp_clients = function()
            local clients = vim.lsp.get_active_clients()
            for _, client in ipairs(clients) do
                local bufs = vim.lsp.get_buffers_by_client_id(client.id)
                if #bufs == 0 then
                    print("stopping LSP client " .. client.name)
                    client:stop()
                end
            end
        end

        vim.defer_fn(delete_empty_lsp_clients, 5000)
    end,
})
---- Time out disconnected, empty LSP clients }}}

---- Use 'q' to quit from common plugins {{{
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "fugitive", "help", "man", "qf" },
    callback = function()
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
        vim.bo.buflisted = false
    end,
})
---- Use 'q' to quit from common plugins }}}

-- vim: foldmethod=marker
