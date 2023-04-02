local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = { -- Override plugin definition options
{
    "williamboman/mason.nvim",
    opts = {
        ensure_installed = {"lua-language-server", "html-lsp", "clangd", "prettier", "typescript-language-server",
                            "eslint-lsp", "tailwindcss-language-server", "rust-analyzer"}
    }
}, {
    "neovim/nvim-lspconfig",
    dependencies = { -- format & linting
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require "custom.configs.null-ls"
        end
    }},
    config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
    end -- Override to setup mason-lspconfig
}, -- overrde plugin configs
{
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter
}, {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree
}, -- Install a plugin
{
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
        require("better_escape").setup()
    end
}, -- plugin for golang
{
    'ray-x/go.nvim',
    init = function()
        local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                require('go.format').goimport()
            end,
            group = format_sync_grp
        })
    end,

    opts = {
        disable_defaults = false,
        go = 'go',
        goimport = 'gopls', -- goimport command, can be gopls[default] or goimport
        fillstruct = 'gopls'
    },
    config = function(_, opts)
        require('go').setup(opts)
    end

} -- To make a plugin not be loaded
-- {
--   "NvChad/nvim-colorizer.lua",
--   enabled = false
-- },
-- Uncomment if you want to re-enable which-key
-- {
--   "folke/which-key.nvim",
--   enabled = true,
-- },
}

return plugins
