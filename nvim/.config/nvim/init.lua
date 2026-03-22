-- Neovim Configuration File
--
-- Set up globals and default options
vim.g.loaded_perl_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.showmode = false
vim.o.compatible = false
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.winborder = "rounded"
vim.o.swapfile = false
vim.o.foldmethod = "syntax"
vim.o.updatetime = 250
vim.o.termguicolors = true

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})


-- Save view (folds, cursor position, etc.) when leaving a buffer or closing nvim
vim.api.nvim_create_autocmd({"BufWinLeave", "BufLeave", "QuitPre"}, {
    pattern = {"*.*"}, -- Apply to all files with a non-empty name
    command = "mkview"
})

-- Load view when entering a buffer
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    pattern = {"*.*"},
    command = "silent! loadview" -- Use silent! to avoid errors if no view file exists
})

-- start lazy.nvim plugin manager
require("config.lazy")

vim.cmd.highlight({ "FloatBorder", "guifg=#bb9af7", "guibg=#1a1b26" })
