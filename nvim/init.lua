-- use default Neovim config if running in VS Code
if vim.g.vscode then
    print("Neovim running in VS Code. Using default config.")
    return
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
