if vim.v.version >= 700 then
    local builtin = require('telescope.builtin')
    setkey = vim.keymap.set
    setkey('n', '<leader>ff', builtin.find_files, {})
    setkey('n', '<leader>fr', builtin.live_grep, {})
    setkey('n', '<leader>fb', builtin.buffers, {})
    setkey('n', '<leader>fg', builtin.git_files, {})
    setkey('n', '<leader>fs', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    setkey('n', '<leader>fh', builtin.help_tags, {})
end
