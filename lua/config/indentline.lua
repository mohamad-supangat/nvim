-- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
local status_ok, indentline = pcall(require, "ibl")
if not status_ok then
    return
end
vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

local exclude = {
    "terminal",
    "startify",
    "nvim-tree",
    "CHADTree",
    "chad-tree",
    "no-profile",
    "alpha",
    "coc-explorer",
    "Starter",
    "starter",
    "FTermm"
}

-- vim.cmd([[highlight IndentBlanklineIndent1 guifg=#666666 gui=nocombine]])
--
-- indentline.setup()
indentline.setup({
    indent = {
        char = "▏",
    },
    exclude = {
        filetypes = exclude,
    },
    scope = {
        enabled = false
    }
    -- show_end_of_line = true,
    -- char_highlight_list = {
    --     "IndentBlanklineIndent1"
    -- }
})

