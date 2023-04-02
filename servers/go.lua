local go_opts = function(opts)
    local default_attach = opts.on_attach
    opts.setting = {formatCommand = ':silent!'}
    opts.on_attach = function(client, buf)
        default_attach(client, buf)
        client.resolved_capabilities.document_formatting = false
        vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre *.go :silent! lua require("go.format").goimport() 
                autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500)
            augroup END
        ]])
        -- Run gofmt + goimport on save
    end
end

return go_opts