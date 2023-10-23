-- https://github.com/nvim-telescope/telescope.nvim
-- See `:help telescope`
local M = { "nvim-telescope/telescope.nvim" }

M.branch = "0.1.x"
M.dependencies = {
    -- https://github.com/nvim-lua/plenary.nvim
    { "nvim-lua/plenary.nvim" },
    -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

M.config = function()
    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

    require("telescope").load_extension("fzf")
end

return M
