return {
  { -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("catppuccin").setup({ flavour = "latte", auto_integrations = true })
      local palettes = require("catppuccin.palettes")
      if not palettes.get and palettes.get_palette then
        palettes.get = palettes.get_palette -- shim pour l’API attendue par LazyVim
      end
    end,
  },
  -- TODO: Remove this once https://github.com/LazyVim/LazyVim/pull/6354 is merged
  {
    "akinsho/bufferline.nvim",
    init = function()
      local bufline = require("catppuccin.groups.integrations.bufferline")
      function bufline.get()
        return bufline.get_theme()
      end
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
