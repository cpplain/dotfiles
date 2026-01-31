return {
    cmd = { "solargraph", "stdio" },
    settings = {
        solargraph = {
            diagnostics = true,
        },
    },
    init_options = { formatting = true },
    filetypes = { "ruby", "eruby" },
    root_markers = { "Gemfile", ".git" },
}
