vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.o.shell = "/opt/homebrew/bin/fish"

vim.opt.breakindent = true
vim.opt.conceallevel = 0
vim.opt.list = false
vim.opt.relativenumber = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.diagnostic.enable(false)

vim.filetype.add({
    extension = {
        h = "c",
    },
    pattern = {
        ["B?b?rewfile.*"] = "ruby",
        [".*/git/config.*"] = "gitconfig",
    },
})
