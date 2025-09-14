-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

local escape_keys = { "jj", "hh", "kk", "ll" }
for _, key in ipairs(escape_keys) do
  map("i", key, "<Esc>", { desc = "Exit insert mode" })
end
