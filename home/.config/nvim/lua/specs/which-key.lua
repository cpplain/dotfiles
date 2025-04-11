return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    -- stylua: ignore
    keys = {
        { "<Leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps (which-key)" },
        { "<C-w><Space>", function() require("which-key").show({ keys = "<C-w>", loop = true }) end, desc = "Window Hydra Mode (which-key)" },
    },

    opts_extend = { "spec" },
    opts = {
        preset = "helix",
        spec = {
            -- stylua: ignore
            {
                mode = { "n", "v" },
                { "<Leader><Tab>", group = "tabs" },
                { "<Leader>c", group = "code" },
                { "<Leader>d", group = "debug" },
                { "<Leader>dp", group = "profiler" },
                { "<Leader>f", group = "file/find" },
                { "<Leader>g", group = "git" },
                { "<Leader>gh", group = "hunks" },
                { "<Leader>q", group = "quit/session" },
                { "<Leader>s", group = "search" },
                { "<Leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
                { "<Leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
                { "[", group = "prev" },
                { "]", group = "next" },
                { "g", group = "goto" },
                { "gs", group = "surround" },
                { "z", group = "fold" },
                { "<Leader>b", group = "buffer", expand = function() return require("which-key.extras").expand.buf() end },
                { "<Leader>w", group = "windows", proxy = "<C-w>", expand = function() return require("which-key.extras").expand.win() end },
                -- better description
                { "gx", desc = "Open with system app" },
            },
        },
    },
}
