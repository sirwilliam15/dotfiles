-- Everforest + Nord Blend — Neovim colorscheme
-- Place in: ~/.config/nvim/colors/everforest-nord.lua
-- Usage: vim.cmd("colorscheme everforest-nord")

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "everforest-nord"
vim.o.termguicolors = true

local c = {
  -- Everforest Dark Hard backgrounds
  bg        = "#1e2326",
  bg1       = "#272e33",
  bg2       = "#2d3b41",
  muted     = "#543a48",
  subtle    = "#7a8478",
  fg        = "#d3c6aa",

  -- Everforest accent colors
  green     = "#a7c080",
  teal      = "#83c092",
  blue      = "#7fbbb3",
  yellow    = "#dbbc7f",
  orange    = "#e69875",
  red       = "#e67e80",
  purple    = "#d699b6",

  -- Nord Frost accents
  frost1    = "#8fbcbb",
  frost2    = "#88c0d0",
  frost3    = "#81a1c1",
  frost4    = "#5e81ac",
  snow      = "#d8dee9",

  none      = "NONE",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor
hi("Normal",           { fg = c.fg, bg = c.bg })
hi("NormalFloat",      { fg = c.fg, bg = c.bg1 })
hi("FloatBorder",      { fg = c.frost3, bg = c.bg1 })
hi("Cursor",           { fg = c.bg, bg = c.fg })
hi("CursorLine",       { bg = c.bg1 })
hi("CursorColumn",     { bg = c.bg1 })
hi("ColorColumn",      { bg = c.bg1 })
hi("LineNr",           { fg = c.subtle })
hi("CursorLineNr",     { fg = c.yellow, bold = true })
hi("SignColumn",       { fg = c.subtle, bg = c.bg })
hi("VertSplit",        { fg = c.bg2 })
hi("WinSeparator",     { fg = c.bg2 })
hi("Folded",           { fg = c.subtle, bg = c.bg1 })
hi("FoldColumn",       { fg = c.subtle, bg = c.bg })
hi("NonText",          { fg = c.bg2 })
hi("SpecialKey",       { fg = c.bg2 })
hi("EndOfBuffer",      { fg = c.bg })

-- Statusline
hi("StatusLine",       { fg = c.fg, bg = c.bg1 })
hi("StatusLineNC",     { fg = c.subtle, bg = c.bg1 })
hi("WildMenu",        { fg = c.bg, bg = c.frost3 })

-- Tabline
hi("TabLine",          { fg = c.subtle, bg = c.bg1 })
hi("TabLineSel",       { fg = c.fg, bg = c.bg, bold = true })
hi("TabLineFill",      { bg = c.bg1 })

-- Search & visual
hi("Search",           { fg = c.bg, bg = c.frost2 })
hi("IncSearch",        { fg = c.bg, bg = c.orange })
hi("CurSearch",        { fg = c.bg, bg = c.orange, bold = true })
hi("Visual",           { bg = c.bg2 })
hi("VisualNOS",        { bg = c.bg2 })
hi("MatchParen",       { fg = c.orange, bold = true, underline = true })

-- Popup menu
hi("Pmenu",            { fg = c.fg, bg = c.bg1 })
hi("PmenuSel",         { fg = c.bg, bg = c.frost3 })
hi("PmenuSbar",        { bg = c.bg2 })
hi("PmenuThumb",       { bg = c.subtle })

-- Messages
hi("ErrorMsg",         { fg = c.red, bold = true })
hi("WarningMsg",       { fg = c.yellow, bold = true })
hi("ModeMsg",          { fg = c.fg, bold = true })
hi("MoreMsg",          { fg = c.green })
hi("Question",         { fg = c.green })

-- Diff
hi("DiffAdd",          { bg = "#2d3b2d" })
hi("DiffChange",       { bg = "#2d3541" })
hi("DiffDelete",       { fg = c.red, bg = "#3b2d2d" })
hi("DiffText",         { bg = "#3b4555", bold = true })

-- Spelling
hi("SpellBad",         { sp = c.red, undercurl = true })
hi("SpellCap",         { sp = c.yellow, undercurl = true })
hi("SpellLocal",       { sp = c.frost2, undercurl = true })
hi("SpellRare",        { sp = c.purple, undercurl = true })

-- Diagnostics
hi("DiagnosticError",         { fg = c.red })
hi("DiagnosticWarn",          { fg = c.yellow })
hi("DiagnosticInfo",          { fg = c.frost2 })
hi("DiagnosticHint",          { fg = c.frost1 })
hi("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hi("DiagnosticUnderlineWarn",  { sp = c.yellow, undercurl = true })
hi("DiagnosticUnderlineInfo",  { sp = c.frost2, undercurl = true })
hi("DiagnosticUnderlineHint",  { sp = c.frost1, undercurl = true })

-- Syntax
hi("Comment",          { fg = c.subtle, italic = true })
hi("Constant",         { fg = c.purple })
hi("String",           { fg = c.green })
hi("Character",        { fg = c.green })
hi("Number",           { fg = c.purple })
hi("Boolean",          { fg = c.purple })
hi("Float",            { fg = c.purple })
hi("Identifier",       { fg = c.fg })
hi("Function",         { fg = c.frost2, bold = true })
hi("Statement",        { fg = c.red })
hi("Conditional",      { fg = c.red })
hi("Repeat",           { fg = c.red })
hi("Label",            { fg = c.orange })
hi("Operator",         { fg = c.orange })
hi("Keyword",          { fg = c.red })
hi("Exception",        { fg = c.red })
hi("PreProc",          { fg = c.frost3 })
hi("Include",          { fg = c.frost3 })
hi("Define",           { fg = c.frost3 })
hi("Macro",            { fg = c.frost3 })
hi("PreCondit",        { fg = c.frost3 })
hi("Type",             { fg = c.yellow })
hi("StorageClass",     { fg = c.yellow })
hi("Structure",        { fg = c.yellow })
hi("Typedef",          { fg = c.yellow })
hi("Special",          { fg = c.orange })
hi("SpecialChar",      { fg = c.orange })
hi("Tag",              { fg = c.frost2 })
hi("Delimiter",        { fg = c.fg })
hi("SpecialComment",   { fg = c.subtle, italic = true })
hi("Debug",            { fg = c.orange })
hi("Underlined",       { fg = c.frost2, underline = true })
hi("Error",            { fg = c.red })
hi("Todo",             { fg = c.yellow, bg = c.bg1, bold = true })

-- Treesitter
hi("@variable",             { fg = c.fg })
hi("@variable.builtin",     { fg = c.teal })
hi("@variable.parameter",   { fg = c.fg })
hi("@constant",             { fg = c.purple })
hi("@constant.builtin",     { fg = c.purple })
hi("@module",               { fg = c.frost3 })
hi("@string",               { fg = c.green })
hi("@string.escape",        { fg = c.orange })
hi("@string.regex",         { fg = c.teal })
hi("@character",            { fg = c.green })
hi("@number",               { fg = c.purple })
hi("@boolean",              { fg = c.purple })
hi("@function",             { fg = c.frost2, bold = true })
hi("@function.builtin",     { fg = c.frost1 })
hi("@function.call",        { fg = c.frost2 })
hi("@function.method",      { fg = c.frost2 })
hi("@constructor",          { fg = c.frost2 })
hi("@keyword",              { fg = c.red })
hi("@keyword.function",     { fg = c.red })
hi("@keyword.return",       { fg = c.red })
hi("@keyword.operator",     { fg = c.orange })
hi("@operator",             { fg = c.orange })
hi("@punctuation.bracket",  { fg = c.fg })
hi("@punctuation.delimiter",{ fg = c.subtle })
hi("@type",                 { fg = c.yellow })
hi("@type.builtin",         { fg = c.yellow })
hi("@property",             { fg = c.blue })
hi("@attribute",            { fg = c.teal })
hi("@tag",                  { fg = c.red })
hi("@tag.attribute",        { fg = c.orange })
hi("@tag.delimiter",        { fg = c.subtle })
hi("@markup.heading",       { fg = c.frost3, bold = true })
hi("@markup.italic",        { italic = true })
hi("@markup.strong",        { bold = true })
hi("@markup.link",          { fg = c.frost2, underline = true })
hi("@markup.raw",           { fg = c.green })

-- Git signs (gitsigns.nvim)
hi("GitSignsAdd",           { fg = c.green })
hi("GitSignsChange",        { fg = c.frost3 })
hi("GitSignsDelete",        { fg = c.red })

-- Telescope
hi("TelescopeBorder",       { fg = c.frost3, bg = c.bg })
hi("TelescopePromptBorder", { fg = c.frost4, bg = c.bg })
hi("TelescopePromptTitle",  { fg = c.bg, bg = c.frost3, bold = true })
hi("TelescopePreviewTitle", { fg = c.bg, bg = c.green, bold = true })
hi("TelescopeResultsTitle", { fg = c.bg, bg = c.frost2, bold = true })
hi("TelescopeSelection",    { bg = c.bg2 })
hi("TelescopeMatching",     { fg = c.orange, bold = true })

-- Indent-blankline
hi("IndentBlanklineChar",           { fg = c.bg2 })
hi("IndentBlanklineContextChar",    { fg = c.frost4 })

-- Lazy / Mason / Which-key
hi("LazyH1",                { fg = c.bg, bg = c.frost3, bold = true })
hi("LazyButton",            { fg = c.fg, bg = c.bg1 })
hi("LazyButtonActive",      { fg = c.bg, bg = c.frost3 })
hi("WhichKey",              { fg = c.frost2 })
hi("WhichKeyGroup",         { fg = c.green })
hi("WhichKeyDesc",          { fg = c.fg })
hi("WhichKeySeparator",     { fg = c.subtle })
