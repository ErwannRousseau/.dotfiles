return {
  "folke/trouble.nvim",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Trouble: Diagnostics" },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
      desc = "Trouble: Buffer Diagnostics",
    },
  },
}
