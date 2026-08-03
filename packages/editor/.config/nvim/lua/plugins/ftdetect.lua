return {
  {
    "LazyVim/LazyVim",
    init = function()
      vim.filetype.add({
        filename = { ["Fastfile"] = "ruby" },
      })
    end,
  },
}
