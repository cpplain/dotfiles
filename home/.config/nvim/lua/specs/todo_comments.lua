return {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    opts = {},

    -- stylua: ignore
    keys = {
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        { "<Leader>xt", "<Cmd>Trouble todo toggle<CR>", desc = "Todo (Trouble)" },
        { "<Leader>xT", "<Cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<CR>", desc = "Todo/Fix/Fixme (Trouble)" },
    },
}
