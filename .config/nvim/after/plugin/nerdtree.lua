
local setkey = nil
if vim.v.version >= 700 then
    setkey = vim.keymap.set
else
    -- vim.cmd("colorscheme gruvbox-material")
    setkey = vim.api.nvim_set_keymap
end
setkey("n", "<leader>t", ":NERDTreeToggle<cr>", {noremap=true})

-- open nerdtree when opening a dir
vim.cmd([[
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
]])

