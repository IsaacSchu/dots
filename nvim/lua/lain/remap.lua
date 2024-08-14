vim.g.mapleader = " "
vim.keymap.set("n", "<leader>d", vim.cmd.Ex)

vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
