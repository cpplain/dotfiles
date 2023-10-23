-- Use default Neovim config if running in VS Code
if vim.g.vscode then
    print("Neovim running in VS Code. Using default Neovim config.")
    return
end

require("config.settings")
require("config.keymaps")
require("config.plugins")
