return {
  {
    "iamcco/markdown-preview.nvim",
    keys = function(_, keys)
      return vim.tbl_filter(function(key)
        return key[1] ~= "<leader>cp"
      end, keys)
    end,
  },
  {
    "folke/snacks.nvim",
    init = function()
      local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")
      local path = vim.env.PATH or ""

      if vim.fn.isdirectory(mason_bin) == 1 and not path:find(mason_bin, 1, true) then
        vim.env.PATH = mason_bin .. ":" .. path
      end

      vim.env.SNACKS_GHOSTTY = "true"
    end,
    opts = {
      image = {
        enabled = true,
        doc = {
          enabled = true,
          inline = true,
          conceal = function(_, type)
            return type == "chart" or type == "math"
          end,
        },
      },
    },
  },
}
