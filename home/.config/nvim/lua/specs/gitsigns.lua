return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},

    -- stylua: ignore
    keys = {
        { "<Leader>gn", function() require("gitsigns").nav_hunk("next") end, desc = "Goto next hunk"},
        { "<Leader>gp", function() require("gitsigns").nav_hunk("prev") end, desc = "Goto prev hunk"},
    }
,
}
