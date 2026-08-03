if not vim.g.vscode then
  return
end

local vscode = require("vscode")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader (LazyVim: <Space>)
map("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-----------------------------------------------------------------------
-- GENERAL
-----------------------------------------------------------------------

map('i', '<C-s>', function()
  vscode.action('vscode-neovim.escape')
  vscode.action('workbench.action.files.save')
end, { silent = true })

map('n', '<C-s>', function()
  vscode.action('workbench.action.files.save')
end, { silent = true })

-- Files / search (LazyVim <leader>f…)
map({ "n", "x" }, "<leader><space>", function() vscode.action("workbench.action.quickOpen") end, opts)      -- "search files"
map({ "n", "x" }, "<leader>ff", function() vscode.action("workbench.action.quickOpen") end, opts)           -- Find file
map({ "n", "x" }, "<leader>fr", function() vscode.action("workbench.action.openRecent") end, opts)          -- Recent
map({ "n", "x" }, "<leader>fb", function() vscode.action("workbench.action.showAllEditorsByMostRecentlyUsed") end, opts) -- Buffers

-- Search/symbols (LazyVim <leader>s…)
map({ "n", "x" }, "<leader>/", function() vscode.action("workbench.action.findInFiles") end, opts)          -- find in files
map({ "n", "x" }, "<leader>sb", function() vscode.action("workbench.action.gotoSymbol") end, opts)          -- document symbols

-- Explorer / sidebar (LazyVim <leader>e)
map({ "n", "x" }, "<leader>e", function() vscode.action("workbench.view.explorer") end, opts)               -- Open Explorer

-- Buffers (LazyVim <leader>b…)
map("n", "<S-l>", function() vscode.action("workbench.action.nextEditor") end, opts)
map("n", "<S-h>", function() vscode.action("workbench.action.previousEditor") end, opts)
map("n", "<leader>bn", function() vscode.action("workbench.action.nextEditor") end, opts)
map("n", "<leader>bp", function() vscode.action("workbench.action.previousEditor") end, opts)
map("n", "<leader>bo", function() vscode.action("workbench.action.closeOtherEditors") end, opts)
map("n", "<leader>bd", function() vscode.action("workbench.action.closeActiveEditor") end, opts)

-- Window (LazyVim <leader>w…)
map("n", "<leader>-", function() vscode.action("workbench.action.splitEditor") end, opts)
map("n", "<leader>|", function() vscode.action("workbench.action.splitEditorOrthogonal") end, opts)
map("n", "<leader>wc", function() vscode.action("workbench.action.closeEditorsInGroup") end, opts)
map("n", "<C-h>", function() vscode.action("workbench.action.focusLeftGroup") end, opts)
map("n", "<C-j>", function() vscode.action("workbench.action.focusBelowGroup") end, opts)
map("n", "<C-k>", function() vscode.action("workbench.action.focusAboveGroup") end, opts)
map("n", "<C-l>", function() vscode.action("workbench.action.focusRightGroup") end, opts)

-- Edition / divers
map({ "n", "x" }, "<leader>xx", function() vscode.action("workbench.actions.view.problems") end, opts)      -- Show Problems - Trouble Like
map({ "n", "x" }, "<leader>/", function() vscode.action("editor.action.commentLine") end, opts)             -- toggle comment
map({ "n", "x" }, "gcc", function() vscode.action("editor.action.commentLine") end, opts)                   -- toggle comment
map({ "n", "x" }, "<leader>r", function() vscode.action("editor.action.startFindReplaceAction") end, opts)  -- replace
map({ "n", "x" }, "<leader>t", function() vscode.action("workbench.action.terminal.toggleTerminal") end, opts)

-- Multi-cursors (Medium)
map({ "n", "x", "i" }, "<C-d>", function()
  vscode.with_insert(function()
    vscode.action("editor.action.addSelectionToNextFindMatch")
  end)
end, opts)

-- Redo
map("n", "<S-u>", "<C-r>", { desc = "Redo" })

-- Visual reindent (classique Lazy)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-----------------------------------------------------------------------
-- 🧠 LSP
-----------------------------------------------------------------------

-- Hover / Signature
map("n", "<S-k>", function() vscode.action("editor.action.showHover") end, opts)

-- Goto*
map("n", "gd", function() vscode.action("editor.action.revealDefinition") end, opts)
map("n", "gD", function() vscode.action("editor.action.revealDeclaration") end, opts)
map("n", "gr", function() vscode.action("editor.action.goToReferences") end, opts)
map("n", "gi", function() vscode.action("editor.action.goToImplementation") end, opts)
map("n", "gt", function() vscode.action("editor.action.goToTypeDefinition") end, opts)
map("n", "gf", function() vscode.action("editor.action.openLink") end, opts)

-- Actions / rename / format (LazyVim <leader>c…)
map({ "n", "x" }, "<leader>ca", function() vscode.action("editor.action.quickFix") end, opts)               -- Code Action
map("n", "<leader>cr", function() vscode.action("editor.action.rename") end, opts)                          -- Rename
map({ "n", "x" }, "<leader>cf", function() vscode.action("editor.action.formatDocument") end, opts)         -- Format file/sel.
map("n", "<leader>cs", function() vscode.action("editor.action.sourceAction") end, opts)                    -- Source actions

-- Diagnostics (LazyVim [d / ]d )
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    pcall(vim.keymap.del, "n", "]d")
    pcall(vim.keymap.del, "n", "[d")

    map("n", "]d", function() vscode.action("editor.action.marker.next") end, opts)
    map("n", "[d", function() vscode.action("editor.action.marker.prev") end, opts)
  end,
})

-----------------------------------------------------------------------
-- 🧱 Git
-----------------------------------------------------------------------
-- Hunk navigation
map("n", "]h", function() vscode.action("workbench.action.editor.nextChange") end, opts)
map("n", "[h", function() vscode.action("workbench.action.editor.previousChange") end, opts)

-----------------------------------------------------------------------
-- 📋 Clipboard
-----------------------------------------------------------------------
map({ "n", "v" }, "<leader>y", '"+y', opts)   -- yank system
map("n", "<leader>Y", '"+Y', opts)
map({ "n", "v" }, "<leader>p", '"+p', opts)
map({ "n", "v" }, "<leader>P", '"+P', opts)

