local M = {}

local function mode()
    local m = vim.api.nvim_get_mode().mode:sub(1, 1):lower()

    if "n" == m then
        return "%#StatusLineModeN# N %#StatusLine# "
    end
    if "i" == m then
        return "%#StatusLineModeI# I %#StatusLine# "
    end
    if "c" == m then
        return "%#StatusLineModeC# C %#StatusLine# "
    end
    if "v" == m or "\22" == m then
        return "%#StatusLineModeV# V %#StatusLine# "
    end
    if "r" == m then
        return "%#StatusLineModeR# R %#StatusLine# "
    end
    if "s" == m or "\19" == m then
        return "%#StatusLineModeV# S %#StatusLine# "
    end
    if "t" == m then
        return "%#StatusLineModeT# T %#StatusLine# "
    end

    return " ? "
end

local function git_head()
    if not vim.b.gitsigns_head then
        return ""
    end
    return vim.b.gitsigns_head .. "  "
end

local function git_status()
    local status = vim.b.gitsigns_status_dict
    if not status then
        return ""
    end
    local parts = {}

    if status.added and status.added > 0 then
        table.insert(parts, "%#GitSignsAdd#+" .. status.added .. "%#StatusLine#")
    end
    if status.changed and status.changed > 0 then
        table.insert(parts, "%#GitSignsChange#~" .. status.changed .. "%#StatusLine#")
    end
    if status.removed and status.removed > 0 then
        table.insert(parts, "%#GitSignsDelete#-" .. status.removed .. "%#StatusLine#")
    end

    return #parts > 0 and table.concat(parts, " ") .. "  " or ""
end

local function diagnostics()
    local counts = vim.diagnostic.count(0)
    local error = counts[vim.diagnostic.severity.ERROR]
    local warn = counts[vim.diagnostic.severity.WARN]
    local info = counts[vim.diagnostic.severity.INFO]
    local hint = counts[vim.diagnostic.severity.HINT]
    local parts = {}

    if error and error > 0 then
        table.insert(parts, "%#DiagnosticError#E:" .. error .. "%#StatusLine#")
    end
    if warn and warn > 0 then
        table.insert(parts, "%#DiagnosticWarn#W:" .. warn .. "%#StatusLine#")
    end
    if info and info > 0 then
        table.insert(parts, "%#DiagnosticInfo#I:" .. info .. "%#StatusLine#")
    end
    if hint and hint > 0 then
        table.insert(parts, "%#DiagnosticHint#H:" .. hint .. "%#StatusLine#")
    end

    return #parts > 0 and table.concat(parts, " ") .. "  " or ""
end

function M.get()
    return table.concat({
        mode(),
        "%t%m%r  ",
        git_head(),
        git_status(),
        diagnostics(),
        "%=",
        "%S  ",
        "%{&fileencoding} %{&fileformat} %y  ",
        "%p%%  ",
        "%l:%c ",
    })
end

function M.setup()
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
        callback = function()
            vim.cmd("redrawstatus")
        end,
        desc = "Refresh statusline when diagnostics change",
    })

    vim.api.nvim_create_autocmd("User", {
        pattern = "GitSignsChanged",
        callback = function()
            vim.cmd("redrawstatus")
        end,
        desc = "Refresh statusline when git status changes",
    })
end

return M
