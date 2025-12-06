-- Neovim Configuration File
--
-- Set up globals and default options
vim.g.loaded_perl_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.compatible = false
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.winborder = "rounded"
vim.o.swapfile = false

-- start lazy.nvim plugin manager
require("config.lazy")

vim.cmd.highlight({ "FloatBorder", "guifg=#bb9af7", "guibg=#1a1b26" })
