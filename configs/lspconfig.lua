local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local gopls_opts = require 'custom.servers.go'
local ts_opts = require 'custom.servers.ts'
local eslint_opts = require 'custom.servers.eslint'
local tailwindcss_opts = require 'custom.servers.tailwindcss'
local rust_opts = require 'custom.servers.rust'

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", 'gopls', 'eslint', 'tailwindcss'  , 'rust_analyzer'}

-- Specific server configuration
local enhance_server_opts = {
  ['tsserver'] = ts_opts,
  ['gopls'] = gopls_opts,
  ['eslint'] = eslint_opts,
  ['tailwindcss'] = tailwindcss_opts,
}

for _, lsp in ipairs(servers) do
  local opts = { capabilities = capabilities, on_attach = attach_default }
  if enhance_server_opts[server] then
    -- Enhance the default opts with the server-specific ones
    enhance_server_opts[server](opts)
  end
  if server == 'rust_analyzer' then
    require('rust-tools').setup(rust_opts(opts))
  end

  lspconfig[lsp].setup(opts)
end

-- 
-- lspconfig.pyright.setup { blabla}
