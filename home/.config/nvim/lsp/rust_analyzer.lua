return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = function(fname)
        local cargo_crate_dir = vim.fs.root(fname, "Cargo.toml")
        local cargo_workspace_root

        if cargo_crate_dir ~= nil then
            local result = vim.system({
                "cargo",
                "metadata",
                "--no-deps",
                "--format-version",
                "1",
                "--manifest-path",
                cargo_crate_dir .. "/Cargo.toml",
            })

            if result and result[1] then
                result = vim.json.decode(table.concat(result, ""))
                if result["workspace_root"] then
                    cargo_workspace_root = vim.fs.normalize(result["workspace_root"])
                end
            end
        end

        return cargo_workspace_root
            or cargo_crate_dir
            or vim.fs.root(fname, "rust-project.json")
            or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    end,
    capabilities = {
        experimental = {
            serverStatusNotification = true,
        },
    },
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
        },
        autoformat = true,
    },
}
