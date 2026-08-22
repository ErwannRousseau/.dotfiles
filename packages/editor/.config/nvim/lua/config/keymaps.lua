-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

local escape_keys = { "jj", "hh", "kk" }
for _, key in ipairs(escape_keys) do
  map("i", key, "<Esc>", { desc = "Exit insert mode" })
end

map({ "n", "x", "i" }, "<C-q>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

map("n", "U", "<C-r>", { desc = "Redo" })

local function set_spell_language(language)
  vim.opt.spelllang = { language }
  vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/" .. language .. ".utf-8.add"
  vim.opt.spell = true
  vim.notify("Spell language: " .. language)
end

map("n", "<leader>uL", function()
  set_spell_language(vim.opt.spelllang:get()[1] == "fr" and "en" or "fr")
end, { desc = "Switch spell language" })

map({ "n", "v" }, "<leader>cp", function()
  local path = vim.fn.expand("%:.")

  if path == "" then
    vim.notify("No file path to copy", vim.log.levels.WARN)
    return
  end

  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy current file path relative to cwd" })
