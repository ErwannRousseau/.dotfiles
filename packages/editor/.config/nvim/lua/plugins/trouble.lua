return {
  "folke/trouble.nvim",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Trouble: Diagnostics" },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
      desc = "Trouble: Buffer Diagnostics",
    },
    {
      "<leader>xd",
      function()
        local enabled = vim.diagnostic.is_enabled()
        if enabled then
          vim.diagnostic.enable(false)
          vim.notify("Diagnostics disabled", vim.log.levels.WARN)
        else
          vim.diagnostic.enable(true)
          vim.notify("Diagnostics enabled", vim.log.levels.INFO)
        end
      end,
      desc = "Toggle diagnostics (global)",
    },
    {
      "<leader>xD",
      function()
        local bufnr = vim.api.nvim_get_current_buf()
        local enabled = vim.diagnostic.is_enabled({ bufnr = bufnr })
        if enabled then
          vim.diagnostic.enable(false, { bufnr = bufnr })
          vim.notify("Diagnostics disabled (buffer)", vim.log.levels.WARN)
        else
          vim.diagnostic.enable(true, { bufnr = bufnr })
          vim.notify("Diagnostics enabled (buffer)", vim.log.levels.INFO)
        end
      end,
      desc = "Toggle diagnostics (buffer)",
    },
  },
}
