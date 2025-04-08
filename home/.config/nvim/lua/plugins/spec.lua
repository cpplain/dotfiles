local blink_cmp = {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = function()
        return {
            completion = {
                -- menu = {
                -- 	border = "rounded",
                -- 	auto_show = false,
                -- },
                -- documentation = { window = { border = "rounded" } },
                ghost_text = { enabled = false },
            },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                -- default = { "lazydev" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                },
            },
            -- signature = { window = { border = "rounded" } },
        }
    end,
    config = function(_, opts)
        require("blink.cmp").setup(opts)
    end,
}

local catppuccin = {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = function()
        return {
            dim_inactive = { enabled = true },
            default_integrations = false,
            integrations = {
                blink_cmp = true,
                flash = true,
                gitsigns = true,
                lsp_trouble = true,
                -- lualine enabled in lualine config
                mason = true,
                markdown = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                        ok = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                        ok = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                noice = true,
                render_markdown = true,
                snacks = { enabled = true },
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        }
    end,
}

local conform = {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            css = { "prettier" },
            go = { "goimports" },
            html = { "prettier" },
            javascript = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
            ruby = { "rubocop" },
            rust = { "rustfmt" },
            toml = { "taplo" },
            typescript = { "prettier" },
            yaml = { "prettier" },
            zig = { "zigfmt" },
        },
    },
}

local flash = {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
	-- stylua: ignore
	keys = {
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		{ "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}

local lazyvim = {
    "LazyVim/LazyVim",
    opts = {
        colorscheme = "catppuccin",
    },
}

local lspconfig = {
    "nvim-lspconfig",
    opts = {
        servers = {
            gopls = {},
            marksman = {},
            ruby_lsp = {},
            rust_analyzer = {},
            taplo = {},
            zls = {},
        },
        inlay_hints = { enabled = false },
    },
}

local lualine = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            -- set an empty statusline till lualine loads
            vim.o.statusline = " "
        else
            -- hide the statusline on the starter page
            vim.o.laststatus = 0
        end
    end,
    opts = function()
        local icons = LazyVim.config.icons

        vim.o.laststatus = vim.g.lualine_laststatus

        return {
            options = {
                theme = "catppuccin",
                section_separators = "",
                component_separators = "",
                globalstatus = vim.o.laststatus == 3,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
            },
            sections = {
                lualine_b = {
                    "branch",
                },
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                    {
                        "diff",
                        symbols = {
                            added = icons.git.added,
                            modified = icons.git.modified,
                            removed = icons.git.removed,
                        },
                    },
                    {
                        "diagnostics",
                        symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warn,
                            info = icons.diagnostics.Info,
                            hint = icons.diagnostics.Hint,
                        },
                    },
                },
                lualine_x = {
                    "encoding",
                    {
                        "fileformat",
                        symbols = {
                            unix = "unix",
                            dos = "dos",
                            mac = "mac",
                        },
                    },
                    "filetype",
                },
            },
            extensions = { "neo-tree", "lazy", "fzf" },
        }
    end,
}

local noice = {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function()
        return {
            cmdline = {
                view = "cmdline",
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                        },
                    },
                    view = "mini",
                },
            },
            presets = {
                bottom_search = true,
                command_palette = false,
                long_message_to_split = true,
                lsp_doc_border = true,
            },
        }
    end,
    -- stylua: ignore
    keys = {
        { "<Leader>sn", "", desc = "+noice"},
        { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
        { "<Leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
        { "<Leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
        { "<Leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
        { "<Leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
        { "<Leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
        { "<C-f>", function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
        { "<C-b>", function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    },
    config = function(_, opts)
        -- HACK: noice shows messages from before it was enabled,
        -- but this is not ideal when Lazy is installing plugins,
        -- so clear the messages in this case.
        if vim.o.filetype == "lazy" then
            vim.cmd([[messages clear]])
        end
        require("noice").setup(opts)
    end,
}

local nvim_autopairs = {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {},
}

local nvim_treesitter = {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0,
    event = { "LazyFile", "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
        { "<C-Space>", desc = "Increment Selection" },
        { "<BS>", desc = "Decrement Selection", mode = "x" },
    },
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "diff",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "go",
            "gomod",
            "gosum",
            "gowork",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "make",
            "markdown",
            "markdown_inline",
            "printf",
            "puppet",
            "python",
            "query",
            "regex",
            "ron",
            "ruby",
            "rust",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "zig",
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-Space>",
                node_incremental = "<C-Space>",
                scope_incremental = false,
                node_decremental = "<BS>",
            },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}

local nvim_treesitter_textobjects = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = vim.fn.argc(-1) == 0,
    event = { "LazyFile", "VeryLazy" },
    opts = {
        textobjects = {
            --stylua: ignore
			move = {
				enable = true,
				goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
				goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
				goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
				goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
			},
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}

local nvim_web_devicons = {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
}

local render_markdown = {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
        enabled = false,
        code = {
            sign = false,
            width = "block",
            right_pad = 1,
        },
        heading = {
            sign = false,
            icons = {},
        },
        checkbox = {
            enabled = false,
        },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
        require("render-markdown").setup(opts)
        Snacks.toggle({
            name = "Render Markdown",
            get = function()
                return require("render-markdown.state").enabled
            end,
            set = function(enabled)
                local m = require("render-markdown")
                if enabled then
                    m.enable()
                else
                    m.disable()
                end
            end,
        }):map("<Leader>um")
    end,
}

local snacks = {
    "folke/snacks.nvim",
    opts = {
        indent = {
            -- disable indent guides
            enabled = false,
        },
        picker = {
            sources = {
                explorer = {
                    -- display hidden files
                    hidden = true,
                },
                files = {
                    -- search hidden files
                    hidden = true,
                },
                grep = {
                    -- search hidden files
                    hidden = true,
                },
            },
        },
    },
}

local trouble = {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
        { "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
        { "<Leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
        { "<Leader>cs", "<Cmd>Trouble symbols toggle<CR>", desc = "Symbols (Trouble)" },
        { "<Leader>cS", "<Cmd>Trouble lsp toggle<CR>", desc = "LSP references/definitions/... (Trouble)" },
        { "<Leader>xL", "<Cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
        { "<Leader>xQ", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
        {
            "[q",
            function()
                if require("trouble").is_open() then
                    require("trouble").prev({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Previous Trouble/Quickfix Item",
        },
        {
            "]q",
            function()
                if require("trouble").is_open() then
                    require("trouble").next({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cnext)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Next Trouble/Quickfix Item",
        },
    },
    opts = {
        modes = {
            lsp = {
                win = { position = "right" },
            },
        },
    },
}

local which_key = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<Leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Keymaps (which-key)",
        },
        {
            "<C-w><Space>",
            function()
                require("which-key").show({ keys = "<C-w>", loop = true })
            end,
            desc = "Window Hydra Mode (which-key)",
        },
    },
    opts = {
        preset = "helix",
        spec = {
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
                {
                    "<Leader>b",
                    group = "buffer",
                    expand = function()
                        return require("which-key.extras").expand.buf()
                    end,
                },
                {
                    "<Leader>w",
                    group = "windows",
                    proxy = "<C-w>",
                    expand = function()
                        return require("which-key.extras").expand.win()
                    end,
                },
                -- better descriptions
                { "gx", desc = "Open with system app" },
            },
        },
    },
}

local disabled = {
    {
        "akinsho/bufferline.nvim",
        -- disable tabs
        enabled = false,
    },
    {
        "MagicDuck/grug-far.nvim",
        enabled = false,
    },
    {
        "williamboman/mason.nvim",
        enabled = false,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        enabled = false,
    },
    {
        "echasnovski/mini.ai",
        enabled = false,
    },
    {
        "echasnovski/mini.icons",
        enabled = false,
    },
    {
        "echasnovski/mini.pairs",
        enabled = false,
    },
    {
        "folke/tokyonight.nvim",
        enabled = false,
    },
    {
        "folke/ts-comments.nvim",
        enabled = false,
    },
}

return {
    blink_cmp,
    catppuccin,
    conform,
    flash,
    lazyvim,
    lspconfig,
    lualine,
    noice,
    nvim_autopairs,
    nvim_treesitter,
    nvim_treesitter_textobjects,
    nvim_web_devicons,
    render_markdown,
    snacks,
    trouble,
    which_key,
    disabled,
}
