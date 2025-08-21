return {
    "folke/lazydev.nvim",
    event = "VeryLazy",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "snacks.nvim", words = { "Snacks" } },
        },
    },
}
