-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

---@module "lazyvim.config"

local opt = vim.opt

-- opt.winborder = "rounded"

-- General
opt.expandtab = true
-- opt.spell = true
opt.spelloptions:prepend("camel")

opt.shell = "nu"
opt.shellcmdflag = "-c"
opt.shellquote = ""
opt.shellxquote = ""

-- LazyVim settings
-- LazyVim.terminal.setup("pwsh")

-- Windows specific settings
local iswin32 = vim.fn.has("win32") == 1

if iswin32 then
  if vim.env.HOME == nil then
    vim.env.HOME = vim.env.USERPROFILE
  end
  if vim.env.USER == nil then
    vim.env.USER = vim.env.USERNAME
  end
end

-- Icons
vim.g.icons = {
  kinds = {
    Array = "󰅪 ",
    BlockMappingPair = "󰅩 ",
    Boolean = " ",
    BreakStatement = "󰙧 ",
    Call = "󰃷 ",
    CaseStatement = "󱃙 ",
    Class = " ",
    Color = "󰏘 ",
    Constant = "󰏿 ",
    Constructor = " ",
    ContinueStatement = "→ ",
    Copilot = " ",
    Declaration = "󰙠 ",
    Delete = "󰩺 ",
    DoStatement = "󰑖 ",
    Element = "󰅩 ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = "󰈔 ",
    Folder = "󰉋 ",
    ForStatement = "󰑖 ",
    Function = "󰊕 ",
    GotoStatement = "󰁔 ",
    Identifier = "󰀫 ",
    IfStatement = "󰇉 ",
    Interface = " ",
    Keyword = "󰌋 ",
    List = "󰅪 ",
    Log = "󰦪 ",
    Lsp = " ",
    Macro = "󰁌 ",
    MarkdownH1 = "󰉫 ",
    MarkdownH2 = "󰉬 ",
    MarkdownH3 = "󰉭 ",
    MarkdownH4 = "󰉮 ",
    MarkdownH5 = "󰉯 ",
    MarkdownH6 = "󰉰 ",
    Method = "󰆧 ",
    Module = "󰏗 ",
    Namespace = "󰅩 ",
    Null = "󰢤 ",
    Number = "󰎠 ",
    Object = "󰅩 ",
    Operator = "󰆕 ",
    Package = "󰆦 ",
    Pair = "󰅪 ",
    Property = " ",
    Reference = "󰦾 ",
    Regex = " ",
    Repeat = "󰑖 ",
    Return = "󰌑 ",
    RuleSet = "󰅩 ",
    Scope = "󰅩 ",
    Section = "󰅩 ",
    Snippet = "󰩫 ",
    Specifier = "󰦪 ",
    Statement = "󰅩 ",
    String = "󰉾 ",
    Struct = " ",
    SwitchStatement = "󰺟 ",
    Table = "󰅩 ",
    Terminal = " ",
    Text = " ",
    Type = " ",
    TypeParameter = "󰆩 ",
    Unit = " ",
    Value = "󰎠 ",
    Variable = "󰀫 ",
    WhileStatement = "󰑖 ",
  },
}

LazyVim.config.icons.kinds = vim.tbl_deep_extend("force", LazyVim.config.icons.kinds, vim.g.icons.kinds)
