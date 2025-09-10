if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end
vim.cmd.highlight("clear")
vim.o.termguicolors = true
vim.g.colors_name = "flexoki"

local function colors()
    -- Flexoki palette
    local c = {
        -- Base
        black = "#100F0F",
        base950 = "#1C1B1A",
        base900 = "#282726",
        base850 = "#343331",
        base800 = "#403E3C",
        base700 = "#575653",
        base600 = "#6F6E69",
        base500 = "#878580",
        base400 = "#9F9D96",
        base300 = "#B7B5AC",
        base200 = "#CECDC3",
        base150 = "#DAD8CE",
        base100 = "#E6E4D9",
        base50 = "#F2F0E5",
        paper = "#FFFCF0",

        -- Red
        red950 = "#261312",
        red900 = "#3E1715",
        red850 = "#551B18",
        red800 = "#6C201C",
        red700 = "#942822",
        red600 = "#AF3029",
        red500 = "#C03E35",
        red400 = "#D14D41",
        red300 = "#E8705F",
        red200 = "#F89A8A",
        red150 = "#FDB2A2",
        red100 = "#FFCABB",
        red50 = "#FFE1D5",

        -- Orange
        orange950 = "#27180E",
        orange900 = "#40200D",
        orange850 = "#59290D",
        orange800 = "#71320D",
        orange700 = "#9D4310",
        orange600 = "#BC5215",
        orange500 = "#CB6120",
        orange400 = "#DA702C",
        orange300 = "#EC8B49",
        orange200 = "#F9AE77",
        orange150 = "#FCC192",
        orange100 = "#FED3AF",
        orange50 = "#FFE7CE",

        -- Yellow
        yellow950 = "#241E08",
        yellow900 = "#3A2D04",
        yellow850 = "#503D02",
        yellow800 = "#664D01",
        yellow700 = "#8E6B01",
        yellow600 = "#AD8301",
        yellow500 = "#BE9207",
        yellow400 = "#D0A215",
        yellow300 = "#DFB431",
        yellow200 = "#ECCB60",
        yellow150 = "#F1D67E",
        yellow100 = "#F6E2A0",
        yellow50 = "#FAEEC6",

        -- Green
        green950 = "#1A1E0C",
        green900 = "#252D09",
        green850 = "#313D07",
        green800 = "#3D4C07",
        green700 = "#536907",
        green600 = "#66800B",
        green500 = "#768D21",
        green400 = "#879A39",
        green300 = "#A0AF54",
        green200 = "#BEC97E",
        green150 = "#CDD597",
        green100 = "#DDE2B2",
        green50 = "#EDEECF",

        -- Cyan
        cyan950 = "#101F1D",
        cyan900 = "#122F2C",
        cyan850 = "#143F3C",
        cyan800 = "#164F4A",
        cyan700 = "#1C6C66",
        cyan600 = "#24837B",
        cyan500 = "#2F968D",
        cyan400 = "#3AA99F",
        cyan300 = "#5ABDAC",
        cyan200 = "#87D3C3",
        cyan150 = "#A2DECE",
        cyan100 = "#BFE8D9",
        cyan50 = "#DDF1E4",

        -- Blue
        blue950 = "#101A24",
        blue900 = "#12253B",
        blue850 = "#133051",
        blue800 = "#163B66",
        blue700 = "#1A4F8C",
        blue600 = "#205EA6",
        blue500 = "#3171B2",
        blue400 = "#4385BE",
        blue300 = "#66A0C8",
        blue200 = "#92BFDB",
        blue150 = "#ABCFE2",
        blue100 = "#C6DDE8",
        blue50 = "#E1ECEB",

        -- Purple
        purple950 = "#1A1623",
        purple900 = "#261C39",
        purple850 = "#31234E",
        purple800 = "#3C2A62",
        purple700 = "#4F3685",
        purple600 = "#5E409D",
        purple500 = "#735EB5",
        purple400 = "#8B7EC8",
        purple300 = "#A699D0",
        purple200 = "#C4B9E0",
        purple150 = "#D3CAE6",
        purple100 = "#E2D9E9",
        purple50 = "#F0EAEC",

        -- Magenta
        magenta950 = "#24131D",
        magenta900 = "#39172B",
        magenta850 = "#4F1B39",
        magenta800 = "#641F46",
        magenta700 = "#87285E",
        magenta600 = "#A02F6F",
        magenta500 = "#B74583",
        magenta400 = "#CE5D97",
        magenta300 = "#E47DA8",
        magenta200 = "#F4A4C2",
        magenta150 = "#F9B9CF",
        magenta100 = "#FCCFDA",
        magenta50 = "#FEE4E5",
    }

    if vim.o.background == "dark" then
        -- Dark theme colors
        return {
            bg = c.black,
            bg2 = c.base950,
            ui = c.base900,
            ui2 = c.base850,
            ui3 = c.base800,
            tx = c.base200,
            tx2 = c.base500,
            tx3 = c.base700,

            -- Accent colors
            red = c.red400,
            red2 = c.red600,
            red3 = c.red800,
            red4 = c.red900,
            orange = c.orange400,
            orange2 = c.orange600,
            orange3 = c.orange800,
            orange4 = c.orange900,
            yellow = c.yellow400,
            yellow2 = c.yellow600,
            yellow3 = c.yellow800,
            yellow4 = c.yellow900,
            green = c.green400,
            green2 = c.green600,
            green3 = c.green800,
            green4 = c.green900,
            cyan = c.cyan400,
            cyan2 = c.cyan600,
            cyan3 = c.cyan800,
            cyan4 = c.cyan900,
            blue = c.blue400,
            blue2 = c.blue600,
            blue3 = c.blue800,
            blue4 = c.blue900,
            purple = c.purple400,
            purple2 = c.purple600,
            purple3 = c.purple800,
            purple4 = c.purple900,
            magenta = c.magenta400,
            magenta2 = c.magenta600,
            magenta3 = c.magenta800,
            magenta4 = c.magenta900,
        }
    else
        -- Light theme colors
        return {
            bg = c.paper,
            bg2 = c.base50,
            ui = c.base100,
            ui2 = c.base150,
            ui3 = c.base200,
            tx = c.base800,
            tx2 = c.base500,
            tx3 = c.base300,

            -- Accent colors
            red = c.red600,
            red2 = c.red400,
            red3 = c.red200,
            red4 = c.red100,
            orange = c.orange600,
            orange2 = c.orange400,
            orange3 = c.orange200,
            orange4 = c.orange100,
            yellow = c.yellow600,
            yellow2 = c.yellow400,
            yellow3 = c.yellow200,
            yellow4 = c.yellow100,
            green = c.green600,
            green2 = c.green400,
            green3 = c.green200,
            green4 = c.green100,
            cyan = c.cyan600,
            cyan2 = c.cyan400,
            cyan3 = c.cyan200,
            cyan4 = c.cyan100,
            blue = c.blue600,
            blue2 = c.blue400,
            blue3 = c.blue200,
            blue4 = c.blue100,
            purple = c.purple600,
            purple2 = c.purple400,
            purple3 = c.purple200,
            purple4 = c.purple100,
            magenta = c.magenta600,
            magenta2 = c.magenta400,
            magenta3 = c.magenta200,
            magenta4 = c.magenta100,
        }
    end
end

local function hl(name, val)
    vim.api.nvim_set_hl(0, name, val)
end

local c = colors()

-- Editor highlights (:help highlight-groups)
hl("ColorColumn", { bg = c.bg2 })
hl("Conceal", { fg = c.tx3 })
hl("CurSearch", { fg = c.tx, bg = c.orange3 })
hl("Cursor", { fg = c.bg, bg = c.tx })
hl("lCursor", { link = "Cursor" })
hl("CursorIM", { link = "Cursor" })
hl("CursorColumn", { link = "CursorLine" })
hl("CursorLine", { bg = c.bg2 })
hl("Directory", { fg = c.blue })
hl("DiffAdd", { fg = c.green, bg = c.green4 })
hl("DiffChange", { fg = c.yellow, bg = c.yellow4 })
hl("DiffDelete", { fg = c.red, bg = c.red4 })
hl("DiffText", { fg = c.tx, bg = c.yellow3 })
hl("EndOfBuffer", { link = "NonText" })
hl("TermCursor", { link = "Cursor" })
hl("ErrorMsg", { fg = c.red })
hl("WinSeparator", { fg = c.ui })
hl("Folded", { fg = c.tx3, bg = c.bg2 })
hl("FoldColumn", { link = "SignColumn" })
hl("SignColumn", { fg = c.tx3 })
hl("IncSearch", { link = "CurSearch" })
hl("Substitute", { link = "Search" })
hl("LineNr", { fg = c.tx3 })
hl("LineNrAbove", { link = "LineNr" })
hl("LineNrBelow", { link = "LineNr" })
hl("CursorLineNr", { fg = c.tx, bg = c.bg2 })
hl("CursorLineFold", { link = "CursorLineSign" })
hl("CursorLineSign", { fg = c.tx3, bg = c.bg2 })
hl("MatchParen", { fg = c.tx2, bold = true })
hl("ModeMsg", { fg = c.tx2 })
hl("MsgArea", {})
hl("MsgSeparator", { link = "StatusLine" })
hl("MoreMsg", { link = "Normal" })
hl("NonText", { fg = c.tx3 })
hl("Normal", { fg = c.tx, bg = c.bg })
hl("NormalFloat", { fg = c.tx, bg = c.bg2 })
hl("FloatBorder", { fg = c.ui, bg = c.bg2 })
hl("FloatTitle", { fg = c.tx, bg = c.bg2, bold = true })
hl("FloatFooter", { fg = c.tx, bg = c.bg2 })
hl("NormalNC", {})
hl("Pmenu", { fg = c.tx2, bg = c.bg2 })
hl("PmenuSel", { fg = c.tx2, bg = c.ui })
hl("PmenuKind", { link = "Pmenu" })
hl("PmenuKindSel", { link = "PmenuSel" })
hl("PmenuExtra", { link = "Pmenu" })
hl("PmenuExtraSel", { link = "PmenuSel" })
hl("PmenuSbar", { link = "Pmenu" })
hl("PmenuThumb", { bg = c.tx3 })
hl("PmenuMatch", { fg = c.tx2, bold = true })
hl("PmenuMatchSelect", { link = "PmenuMatch" })
hl("ComplMatchIns", {})
hl("Question", { fg = c.blue })
hl("QuickFixLine", { fg = c.cyan })
hl("Search", { fg = c.tx, bg = c.yellow3 })
hl("SnippetTabstop", { link = "Visual" })
hl("SpecialKey", { fg = c.tx3 })
hl("SpellBad", { sp = c.red, undercurl = true })
hl("SpellCap", { sp = c.yellow, undercurl = true })
hl("SpellLocal", { sp = c.cyan, undercurl = true })
hl("SpellRare", { sp = c.purple, undercurl = true })
hl("StatusLine", { fg = c.tx, bg = c.ui })
hl("StatusLineNC", { fg = c.tx3, bg = c.bg2 })
hl("StatusLineTerm", { link = "StatusLine" })
hl("StatusLineTermNC", { link = "StatusLineNC" })
hl("TabLine", { link = "StatusLineNC" })
hl("TabLineFill", { link = "TabLine" })
hl("TabLineSel", { fg = c.tx, bold = true })
hl("Title", { fg = c.tx, bold = true })
hl("Visual", { bg = c.blue4 })
hl("VisualNOS", { link = "Visual" })
hl("WarningMsg", { fg = c.orange })
hl("Whitespace", { link = "NonText" })
hl("WildMenu", { link = "PmenuSel" })
hl("WinBar", { link = "StatusLine" })
hl("WinBarNC", { link = "StatusLineNC" })

-- Syntax highlights (:help group-name)
hl("Comment", { fg = c.tx3 })
hl("Constant", { fg = c.yellow })
hl("String", { fg = c.green })
hl("Character", { fg = c.orange })
hl("Number", { fg = c.orange })
hl("Boolean", { fg = c.orange })
hl("Float", { link = "Number" })

hl("Identifier", { fg = c.tx })
hl("Function", { fg = c.blue })

hl("Statement", { link = "Keyword" })
hl("Conditional", { link = "Keyword" })
hl("Repeat", { link = "Keyword" })
hl("Label", { link = "Keyword" })
hl("Operator", { fg = c.tx })
hl("Keyword", { fg = c.magenta })
hl("Exception", { link = "Keyword" })

hl("PreProc", { fg = c.orange })
hl("Include", { fg = c.cyan })
hl("Define", { link = "PreProc" })
hl("Macro", { fg = c.purple })
hl("PreCondit", { link = "PreProc" })

hl("Type", { fg = c.cyan })
hl("StorageClass", { link = "Type" })
hl("Structure", { link = "Type" })
hl("Typedef", { link = "Type" })

hl("Special", { fg = c.orange })
hl("SpecialChar", { link = "Special" })
hl("Tag", { link = "Special" })
hl("Delimiter", { link = "Special" })
hl("SpecialComment", { link = "Special" })
hl("Debug", { link = "Special" })

hl("Underlined", { underline = true })
hl("Ignore", { fg = c.tx3 })
hl("Error", { fg = c.red })
hl("Todo", { fg = c.cyan, bold = true })

hl("Added", { fg = c.green })
hl("Changed", { fg = c.yellow })
hl("Removed", { fg = c.red })

-- Diagnostic highlights (:help diagnostic-highlights)
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.orange })
hl("DiagnosticInfo", { fg = c.blue })
hl("DiagnosticHint", { fg = c.tx2 })
hl("DiagnosticOk", { fg = c.green })

hl("DiagnosticVirtualTextError", { link = "DiagnosticError" })
hl("DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
hl("DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
hl("DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
hl("DiagnosticVirtualTextOk", { link = "DiagnosticOk" })

hl("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = c.orange, undercurl = true })
hl("DiagnosticUnderlineInfo", { sp = c.blue, undercurl = true })
hl("DiagnosticUnderlineHint", { sp = c.tx2, undercurl = true })
hl("DiagnosticUnderlineOk", { sp = c.green, undercurl = true })

hl("DiagnosticFloatingError", { link = "DiagnosticError" })
hl("DiagnosticFloatingWarn", { link = "DiagnosticWarn" })
hl("DiagnosticFloatingInfo", { link = "DiagnosticInfo" })
hl("DiagnosticFloatingHint", { link = "DiagnosticHint" })
hl("DiagnosticFloatingOk", { link = "DiagnosticOk" })

hl("DiagnosticSignError", { link = "DiagnosticError" })
hl("DiagnosticSignWarn", { link = "DiagnosticWarn" })
hl("DiagnosticSignInfo", { link = "DiagnosticInfo" })
hl("DiagnosticSignHint", { link = "DiagnosticHint" })
hl("DiagnosticSignOk", { link = "DiagnosticOk" })

hl("DiagnosticDeprecated", { sp = c.red, strikethrough = true })
hl("DiagnosticUnnecessary", { link = "Comment" })

-- Treesitter highlights (:help treesitter-highlight-groups)
hl("@variable", { fg = c.tx })
hl("@variable.builtin", { fg = c.magenta })
hl("@variable.parameter", { fg = c.tx2 })
hl("@variable.parameter.builtin", { fg = c.magenta })
hl("@variable.member", { fg = c.tx })

hl("@constant", { link = "Constant" })
hl("@constant.builtin", { fg = c.orange })
hl("@constant.macro", { link = "PreProc" })

hl("@module", { link = "Structure" })
hl("@module.builtin", { link = "Special" })
hl("@label", { link = "Label" })

hl("@string", { link = "String" })
hl("@string.documentation", { link = "String" })
hl("@string.regexp", { link = "Special" })
hl("@string.escape", { fg = c.purple })
hl("@string.special", { link = "SpecialChar" })
hl("@string.special.symbol", { link = "Special" })
hl("@string.special.path", { link = "Special" })
hl("@string.special.url", { link = "Underlined" })

hl("@character", { link = "Character" })
hl("@character.special", { link = "Special" })

hl("@boolean", { link = "Boolean" })
hl("@number", { link = "Number" })
hl("@float", { link = "Float" })

hl("@type", { link = "Type" })
hl("@type.builtin", { link = "Special" })
hl("@type.definition", { link = "Type" })

hl("@attribute", { fg = c.tx2 })
hl("@attribute.builtin", { link = "Special" })
hl("@property", { fg = c.tx })

hl("@function", { link = "Function" })
hl("@function.builtin", { fg = c.purple })
hl("@function.call", { link = "Function" })
hl("@function.macro", { fg = c.purple })

hl("@function.method", { link = "Function" })
hl("@function.method.call", { link = "Function" })

hl("@constructor", { link = "Special" })
hl("@operator", { link = "Operator" })

hl("@keyword", { link = "Keyword" })
hl("@keyword.coroutine", { link = "Keyword" })
hl("@keyword.function", { link = "Keyword" })
hl("@keyword.operator", { link = "Keyword" })
hl("@keyword.import", { fg = c.cyan })
hl("@keyword.type", { link = "Type" })
hl("@keyword.modifier", { link = "Keyword" })
hl("@keyword.repeat", { link = "Repeat" })
hl("@keyword.return", { link = "Keyword" })
hl("@keyword.debug", { link = "Debug" })
hl("@keyword.exception", { link = "Exception" })

hl("@keyword.conditional", { link = "Conditional" })
hl("@keyword.conditional.ternary", { link = "Conditional" })

hl("@keyword.directive", { link = "PreProc" })
hl("@keyword.directive.define", { link = "PreProc" })

hl("@punctuation.delimiter", { fg = c.tx2 })
hl("@punctuation.bracket", { fg = c.tx2 })
hl("@punctuation.special", { link = "Special" })

hl("@comment", { link = "Comment" })
hl("@comment.documentation", { link = "Comment" })

hl("@comment.error", { link = "DiagnosticError" })
hl("@comment.warning", { link = "DiagnosticWarn" })
hl("@comment.todo", { link = "Todo" })
hl("@comment.note", { link = "DiagnosticInfo" })

hl("@markup.strong", { bold = true })
hl("@markup.italic", { italic = true })
hl("@markup.strikethrough", { strikethrough = true })
hl("@markup.underline", { underline = true })

hl("@markup.heading", { link = "Title" })
hl("@markup.heading.1", { link = "Title" })
hl("@markup.heading.2", { link = "Title" })
hl("@markup.heading.3", { link = "Title" })
hl("@markup.heading.4", { link = "Title" })
hl("@markup.heading.5", { link = "Title" })
hl("@markup.heading.6", { link = "Title" })

hl("@markup.quote", { italic = true })
hl("@markup.math", { link = "Special" })

hl("@markup.link", { fg = c.cyan, underline = true })
hl("@markup.link.label", { link = "@markup.link" })
hl("@markup.link.url", { link = "@markup.link" })

hl("@markup.raw", { bg = c.bg2 })
hl("@markup.raw.block", { link = "@markup.raw" })

hl("@markup.list", { fg = c.tx2 })
hl("@markup.list.checked", { fg = c.green, bg = c.green4 })
hl("@markup.list.unchecked", { fg = c.tx2, bg = c.bg2 })

hl("@diff.plus", { link = "Added" })
hl("@diff.minus", { link = "Removed" })
hl("@diff.delta", { link = "Changed" })

hl("@tag", { fg = c.blue })
hl("@tag.builtin", { link = "@tag" })
hl("@tag.attribute", { fg = c.tx2 })
hl("@tag.delimiter", { fg = c.tx2 })

-- LSP semantic token highlights
hl("@lsp.type.comment", { link = "@comment" })
hl("@lsp.type.enum", { link = "@type" })
hl("@lsp.type.enumMember", { link = "@constant" })
hl("@lsp.type.interface", { fg = c.cyan })
hl("@lsp.type.keyword", { link = "@keyword" })
hl("@lsp.type.namespace", { link = "@module" })
hl("@lsp.type.parameter", { link = "@variable.parameter" })
hl("@lsp.type.property", { link = "@property" })
hl("@lsp.type.variable", { link = "@variable" })
hl("@lsp.type.macro", { fg = c.purple })
hl("@lsp.type.method", { link = "@function.method" })
hl("@lsp.type.number", { link = "@number" })
hl("@lsp.type.operator", { link = "@operator" })
hl("@lsp.type.string", { link = "@string" })
hl("@lsp.type.struct", { link = "@type" })
hl("@lsp.type.type", { link = "@type" })
hl("@lsp.type.typeParameter", { link = "@type.definition" })
hl("@lsp.type.decorator", { link = "@attribute" })
hl("@lsp.type.builtinType", { link = "@type.builtin" })
hl("@lsp.type.function", { link = "@function" })
hl("@lsp.type.class", { link = "@type" })

-- Custom statusline highlights
hl("StatusLineModeN", { fg = c.blue })
hl("StatusLineModeI", { fg = c.green })
hl("StatusLineModeV", { fg = c.magenta })
hl("StatusLineModeR", { fg = c.red })
hl("StatusLineModeC", { fg = c.orange })
hl("StatusLineModeT", { fg = c.green })

-- gitsigns.nvim highlights (:help gitsigns-highlight-groups)
hl("GitSignsDeleteLn", { link = "DiffDelete" })
hl("GitSignsStagedAdd", { fg = c.green3 })
hl("GitSignsStagedChange", { fg = c.yellow3 })
hl("GitSignsStagedDelete", { fg = c.red3 })
hl("GitSignsStagedChangedelete", { link = "GitSignsStagedChange" })
hl("GitSignsStagedTopdelete", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedUntracked", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedAddNr", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedChangeNr", { link = "GitSignsStagedChange" })
hl("GitSignsStagedDeleteNr", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedChangedeleteNr", { link = "GitSignsStagedChange" })
hl("GitSignsStagedTopdeleteNr", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedUntrackedNr", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedAddLn", { fg = c.green3, bg = c.green4 })
hl("GitSignsStagedChangeLn", { fg = c.yellow3, bg = c.yellow4 })
hl("GitSignsStagedDeleteLn", { fg = c.red3, bg = c.red4 })
hl("GitSignsStagedChangedeleteLn", { link = "GitSignsStagedChangeLn" })
hl("GitSignsStagedTopdeleteLn", { link = "GitSignsStagedDeleteLn" })
hl("GitSignsStagedUntrackedLn", { link = "GitSignsStagedAddLn" })
hl("GitSignsStagedAddCul", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedChangeCul", { link = "GitSignsStagedChange" })
hl("GitSignsStagedDeleteCul", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedChangedeleteCul", { link = "GitSignsStagedChange" })
hl("GitSignsStagedTopdeleteCul", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedUntrackedCul", { link = "GitSignsStagedAdd" })
