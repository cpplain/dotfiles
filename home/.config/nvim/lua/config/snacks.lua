local header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]

require("snacks").setup({
    explorer = {},
    toggle = {},
    dashboard = {
        preset = {
            header = header,
            -- stylua: ignore
            keys = {
                { icon = " ", key = "f", desc = "Find File", action = "<Leader>ff" },
                { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                { icon = " ", key = "g", desc = "Find Text", action = "<Leader>sg" },
                { icon = " ", key = "r", desc = "Recent Files", action = "<Leader>fr" },
                { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
        },
    },
    picker = {
        hidden = true,
        sources = {
            explorer = {
                hidden = true,
            },
            files = {
                hidden = true,
            },
            grep = {
                hidden = true,
            },
        },
        ---@diagnostic disable-next-line: missing-fields
        icons = {
            files = {
                enabled = false,
            },
            git = {
                enabled = false,
            },
        },
    },
})

local map = vim.keymap.set

-- stylua: ignore start
map("n", "<Leader>e", function() Snacks.explorer() end, { desc = "Open file explorer (snacks)" })
map("n", "<Leader>n", function() Snacks.picker.notifications() end, { desc = "Show notification history" })
map("n", "<Leader>bd", function() Snacks.bufdelete() end, { desc = "Delete buffer" })
map("n", "<Leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete other buffers" })
map("n", "<Leader>fb", function() Snacks.picker.buffers() end, { desc = "Find open buffer" })
map("n", "<Leader>ff", function() Snacks.picker.files() end, { desc = "Find files" })
map("n", "<Leader>fr", function() Snacks.picker.recent() end, { desc = "Find recent file" })
map("n", "<Leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git diff" })
map("n", "<Leader>gl", function() Snacks.picker.git_log() end, { desc = "Git log" })
map("n", "<Leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git log line" })
map("n", "<Leader>gs", function() Snacks.picker.git_status() end, { desc = "Git status" })
map("n", "<Leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git stash" })
map("n", "<Leader>ld", function() Snacks.picker.lsp_definitions() end, { desc = "Goto definition" })
map("n", "<Leader>lD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto declaration" })
map("n", "<Leader>lI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto implementation" })
map("n", "<Leader>lr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "Goto references" })
map("n", "<Leader>ly", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto type definition" })
map("n", "<Leader>rf", function() Snacks.rename.rename_file() end, { desc = "Rename file" })
map("n", "<Leader>sa", function() Snacks.picker.autocmds() end, { desc = "Search autocmds" })
map("n", "<Leader>sb", function() Snacks.picker.lines() end, { desc = "Grep buffer lines" })
map("n", "<Leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep open buffers" })
map("n", "<Leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Search diagnostics" })
map("n", "<Leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Search buffer diagnostics" })
map("n", "<Leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<Leader>sh", function() Snacks.picker.help() end, { desc = "Search help" })
map("n", "<Leader>sH", function() Snacks.picker.highlights() end, { desc = "Search highlights" })
map("n", "<Leader>si", function() Snacks.picker.icons() end, { desc = "Search icons" })
map("n", "<Leader>sj", function() Snacks.picker.jumps() end, { desc = "Search jumps" })
map("n", "<Leader>sk", function() Snacks.picker.keymaps() end, { desc = "Search keymaps" })
map("n", "<Leader>sm", function() Snacks.picker.marks() end, { desc = "Search marks" })
map("n", "<Leader>sM", function() Snacks.picker.man() end, { desc = "Search man pages" })
map("n", "<Leader>sp", function() Snacks.picker.lazy() end, { desc = "Grep plugin spec" })
map("n", "<Leader>sq", function() Snacks.picker.qflist() end, { desc = "Search quickfix list" })
map("n", "<Leader>sr", function() Snacks.picker.resume() end, { desc = "Search resume" })
map("n", "<Leader>su", function() Snacks.picker.undo() end, { desc = "Search undo history" })
map({ "n", "x" }, "<Leader>sw", function() Snacks.picker.grep_word() end, { desc = "Grep visual selection or word" })
-- stylua: ignore end

Snacks.toggle.option("conceallevel", { off = 0, on = 2, name = "Conceal Level" }):map("<Leader>tc")
Snacks.toggle.diagnostics():map("<Leader>td")
Snacks.toggle.dim():map("<Leader>tD")
Snacks.toggle({
    name = "Format on Save",
    get = function()
        return vim.g.autoformat
    end,
    set = function()
        vim.g.autoformat = not vim.g.autoformat
    end,
}):map("<leader>tf")
Snacks.toggle({
    name = "Git Signs",
    get = function()
        return require("gitsigns.config").config.signcolumn
    end,
    set = function()
        require("gitsigns").toggle_signs()
    end,
}):map("<leader>tg")
Snacks.toggle.line_number():map("<Leader>tl")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<Leader>tL")
Snacks.toggle.option("spell", { name = "Spelling" }):map("<Leader>ts")
Snacks.toggle.treesitter():map("<Leader>tt")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<Leader>tw")
Snacks.toggle.zen():map("<leader>tz")
