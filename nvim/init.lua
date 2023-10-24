-- Use default Neovim config if running in VS Code
if vim.g.vscode then
    print("Neovim running in VS Code. Using default Neovim config.")
    return
end

require("options")
require("keymaps")

-- https://github.com/folke/lazy.nvim#-structuring-your-plugins
-- See `:help lazy.nvim`
local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        path,
    })
end
vim.opt.rtp:prepend(path)

require("lazy").setup("plugins", {
    ui = {
        -- Replace Nerd Font icons with Unicode symbols
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})
