-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.filetype.add({
  extension = {
    axaml = "xml",
    xaml = "xml",
  },
})

vim.opt.relativenumber = true -- относительные номера строк
vim.g.snacks_animate = false
