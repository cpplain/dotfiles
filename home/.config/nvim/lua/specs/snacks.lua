local M = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
}

-- stylua: ignore
M.keys = {
    -- TODO: Add root and cwd versions where applicable (e.g., `.files()`)
    { "<Leader>e", "<Leader>fe", desc = "File Explorer", remap = true },
    { "<Leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    -- find
    { "<Leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<Leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<Leader>fe", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<Leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<Leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<Leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<Leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    -- git
    { "<Leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<Leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<Leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<Leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<Leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    -- grep
    { "<Leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<Leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<Leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<Leader>sp", function() Snacks.picker.lazy() end, desc = "Plugin Spec" },
    { "<Leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- search
    { '<Leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { '<Leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<Leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<Leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<Leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<Leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<Leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<Leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<Leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<Leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<Leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<Leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<Leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<Leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<Leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<Leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    { "<Leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<Leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<Leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- other
    { "<Leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<Leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    { "<Leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<Leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<Leader>bo", function() Snacks.bufdelete().other() end, desc = "Delete Other Buffers" },
    { "<Leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    { "<Leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<Leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
}

---@type snacks.Config
M.opts = {
    dashboard = {},
    explorer = {},
    picker = {},
    toggle = {},
}
M.opts.dashboard = {
    preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        -- stylua: ignore
        keys = {
            { icon = " ", key = "f", desc = "Find File", action = "<Leader>ff" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "p", desc = "Projects", action = "<Leader>fp" },
            { icon = " ", key = "g", desc = "Find Text", action = "<Leader>sg" },
            { icon = " ", key = "r", desc = "Recent Files", action = "<Leader>fr" },
            { icon = " ", key = "c", desc = "Config", action = "<Leader>fc" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
    },
}
M.opts.picker = {
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
}

M.config = function(_, opts)
    require("snacks").setup(opts)

    Snacks.toggle.profiler_highlights():map("<Leader>dph")
    Snacks.toggle.profiler():map("<Leader>dpp")
    Snacks.toggle.option("conceallevel", { off = 0, on = 2, name = "Conceal Level" }):map("<Leader>uc")
    Snacks.toggle.diagnostics():map("<Leader>ud")
    Snacks.toggle.dim():map("<Leader>uD")
    -- TODO: Add buffer specific toggle
    Snacks.toggle({
        name = "Format on Save",
        get = function()
            return vim.g.autoformat
        end,
        set = function()
            vim.g.autoformat = not vim.g.autoformat
        end,
    }):map("<leader>uf")
    Snacks.toggle.indent():map("<Leader>ug")
    Snacks.toggle({
        name = "Git Signs",
        get = function()
            return require("gitsigns.config").config.signcolumn
        end,
        set = function()
            require("gitsigns").toggle_signs()
        end,
    }):map("<leader>uG")
    Snacks.toggle.inlay_hints():map("<leader>uh")
    Snacks.toggle.line_number():map("<Leader>ul")
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<Leader>uL")
    Snacks.toggle.option("spell", { name = "Spelling" }):map("<Leader>us")
    Snacks.toggle.treesitter():map("<Leader>uT")
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<Leader>uw")
    Snacks.toggle.zen():map("<leader>uz")
end

return M
