return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,

    -- stylua: ignore
    keys = {
        -- TODO: Add root and cwd versions where applicable (e.g., `.files()`)
        { "<Leader>e", function() Snacks.explorer() end, desc = "Open file explorer (snacks)" },
        { "<Leader>n", function() Snacks.picker.notifications() end, desc = "Show notification history" },
        -- find
        { "<Leader>fb", function() Snacks.picker.buffers() end, desc = "Find open buffer" },
        { "<Leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
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
        { "<Leader>sa", function() Snacks.picker.autocmds() end, desc = "Search autocmds" },
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
        { "<Leader>sR", function() Snacks.picker.resume() end, desc = "Search resume" },
        { "<Leader>su", function() Snacks.picker.undo() end, desc = "Search undo history" },
        -- LSP
        { "<Leader>ld", function() Snacks.picker.lsp_definitions() end, desc = "Goto definition" },
        { "<Leader>lD", function() Snacks.picker.lsp_declarations() end, desc = "Goto declaration" },
        { "<Leader>lI", function() Snacks.picker.lsp_implementations() end, desc = "Goto implementation" },
        { "<Leader>lr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "Goto references" },
        { "<Leader>ly", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto type definition" },
        -- other
        { "<Leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
        { "<Leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
        { "<Leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file" },
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

        Snacks.toggle.option("conceallevel", { off = 0, on = 2, name = "Conceal Level" }):map("<Leader>tc")
        Snacks.toggle.diagnostics():map("<Leader>td")
        Snacks.toggle.dim():map("<Leader>tD")
        -- TODO: Add buffer specific toggle
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
    end,
}
