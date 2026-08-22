return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}

      opts.linters_by_ft.swift = { "swiftlint" }
      opts.linters_by_ft.php = {}
      opts.linters_by_ft.markdown = { "markdownlint-cli2" }

      local markdownlint = require("lint").linters["markdownlint-cli2"]
      markdownlint.cmd = vim.fn.stdpath("data") .. "/mason/bin/markdownlint-cli2"
      markdownlint.args = {
        "--config",
        vim.fn.stdpath("config") .. "/.markdownlint-cli2.jsonc",
        "-",
      }
    end,
  },
}
