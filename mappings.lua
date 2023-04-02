---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  i = {
    ["jk"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "" },
  }
}

-- more keybinds!

return M
