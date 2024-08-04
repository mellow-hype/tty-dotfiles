
-- enable full color support
vim.opt.termguicolors = true

-- set default dark background
vim.opt.background = "dark"

-- set colorscheme
if vim.v.version >= 700 then
    -- vim.cmd.colorscheme('gruvbox-material')
    vim.cmd.colorscheme('base16-irblack')
else
    vim.cmd("colorscheme base16-irblack")
end
