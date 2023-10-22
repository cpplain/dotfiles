-- https://github.com/catppuccin/nvim
local M = { "catppuccin/nvim" }

M.name = "catppuccin"
M.lazy = false
M.priority = 1000

function M.config()
    vim.cmd.colorscheme("catppuccin")
end

return M
