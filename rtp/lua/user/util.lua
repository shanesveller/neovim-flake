local M = {}

-- Credit: https://github.com/folke/LazyVim/blob/ce322b70420f1b0ec94bfab0d2fb6d104875b5e6/lua/lazyvim/util.lua#L6
M.on_attach = function(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

return M
