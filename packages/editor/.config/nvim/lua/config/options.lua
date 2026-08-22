-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_picker = "fzf"

-- Set to false to disable auto format
vim.g.lazyvim_eslint_auto_format = true

-- Enable this option to avoid conflicts with Prettier.
vim.g.lazyvim_prettier_needs_config = true

vim.g.root_spec = { "cwd" }

vim.opt.spell = false
vim.opt.spelllang = { "en" }
