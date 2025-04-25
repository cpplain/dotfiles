return {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoTrouble", "TodoTelescope" },

    -- stylua: ignore
    keys = {
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        ---@diagnostic disable-next-line: undefined-field
        { "<Leader>st", function() Snacks.picker.todo_comments() end, desc = "Search todo comments" },
        { "<Leader>xt", "<Cmd>Trouble todo toggle<CR>", desc = "Todo (Trouble)" },
        { "<Leader>xT", "<Cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<CR>", desc = "Todo/Fix/Fixme (Trouble)" },
    },

    opts = {
        signs = false,
        keywords = {
            FIX = { icon = "" },
            TODO = { icon = "" },
            HACK = { icon = "" },
            WARN = { icon = "" },
            PERF = { icon = "" },
            NOTE = { icon = "" },
            TEST = { icon = "" },
        },
        search = {
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--hidden",
            },
        },
    },
}
