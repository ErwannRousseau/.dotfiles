return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        swift = { "swiftformat" },
        markdown = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
      },

      formatters = {
        swiftformat = {
          prepend_args = { "--indent", "2" },
        },

        prettier = {
          prepend_args = {
            "--ignore-path",
            ".prettierignore",
            "--print-width",
            "80",
            "--prose-wrap",
            "always",
          },
        },
      },
    },
  },
}
