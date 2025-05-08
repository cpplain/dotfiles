return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,

    -- stylua: ignore
    keys = {
        -- TODO: Add root and cwd versions where applicable (e.g., `.files()`)
        { "<Leader>e", "<Leader>fe", desc = "Open file explorer (snacks)", remap = true },
        { "<Leader>n", function() Snacks.picker.notifications() end, desc = "Show notification history" },
        -- find
        { "<Leader>fb", function() Snacks.picker.buffers() end, desc = "Find open buffer" },
        { "<Leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find config file" },
        { "<Leader>fe", function() Snacks.explorer() end, desc = "Open file explorer (snacks)" },
        { "<Leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
        { "<Leader>fg", function() Snacks.picker.git_files() end, desc = "Find git file" },
        { "<Leader>fp", function() Snacks.picker.projects() end, desc = "Find projects" },
        { "<Leader>fr", function() Snacks.picker.recent() end, desc = "Find recent file" },
        -- git
        { "<Leader>gd", function() Snacks.picker.git_diff() end, desc = "Git diff" },
        { "<Leader>gl", function() Snacks.picker.git_log() end, desc = "Git log" },
        { "<Leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git log line" },
        { "<Leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
        { "<Leader>gS", function() Snacks.picker.git_stash() end, desc = "Git stash" },
        -- grep
        { "<Leader>sb", function() Snacks.picker.lines() end, desc = "Grep buffer lines" },
        { "<Leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep open buffers" },
        { "<Leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<Leader>sp", function() Snacks.picker.lazy() end, desc = "Grep plugin spec" },
        { "<Leader>sw", function() Snacks.picker.grep_word() end, desc = "Grep visual selection or word", mode = { "n", "x" } },
        -- search
        { '<Leader>s"', function() Snacks.picker.registers() end, desc = "Search registers" },
        { '<Leader>s/', function() Snacks.picker.search_history() end, desc = "Search history" },
        { "<Leader>sa", function() Snacks.picker.autocmds() end, desc = "Search autocmds" },
        { "<Leader>sc", function() Snacks.picker.command_history() end, desc = "Command history" },
        { "<Leader>sC", function() Snacks.picker.commands() end, desc = "Search commands" },
        { "<Leader>sd", function() Snacks.picker.diagnostics() end, desc = "Search diagnostics" },
        { "<Leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Search buffer diagnostics" },
        { "<Leader>sh", function() Snacks.picker.help() end, desc = "Search help" },
        { "<Leader>sH", function() Snacks.picker.highlights() end, desc = "Search highlights" },
        { "<Leader>si", function() Snacks.picker.icons() end, desc = "Search icons" },
        { "<Leader>sj", function() Snacks.picker.jumps() end, desc = "Search jumps" },
        { "<Leader>sk", function() Snacks.picker.keymaps() end, desc = "Search keymaps" },
        { "<Leader>sm", function() Snacks.picker.marks() end, desc = "Search marks" },
        { "<Leader>sM", function() Snacks.picker.man() end, desc = "Search man pages" },
        { "<Leader>sq", function() Snacks.picker.qflist() end, desc = "Search quickfix list" },
        { "<Leader>sR", function() Snacks.picker.resume() end, desc = "Searc resume" },
        { "<Leader>su", function() Snacks.picker.undo() end, desc = "Search undo history" },
        -- LSP
        { "<Leader>ld", function() Snacks.picker.lsp_definitions() end, desc = "Goto definition" },
        { "<Leader>lD", function() Snacks.picker.lsp_declarations() end, desc = "Goto declaration" },
        { "<Leader>lI", function() Snacks.picker.lsp_implementations() end, desc = "Goto implementation" },
        { "<Leader>lr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "Goto references" },
        { "<Leader>ly", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto type definition" },
        { "<Leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "Search LSP symbols" },
        { "<Leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Search LSP workspace Symbols" },
        -- other
        { "<Leader>.", function() Snacks.scratch() end, desc = "Toggle scratch buffer" },
        { "<Leader>S", function() Snacks.scratch.select() end, desc = "Select scratch buffer" },
        { "<Leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
        { "<Leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
        { "<Leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file" },
        { "<Leader>gg", function() Snacks.lazygit() end, desc = "Open lazygit" },
        { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference", mode = { "n", "t" } },
        { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev reference", mode = { "n", "t" } },
    },

    ---@type snacks.Config
    opts = {
        explorer = {},
        toggle = {},

        dashboard = {
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
    },

    config = function(_, opts)
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
    end,
}
