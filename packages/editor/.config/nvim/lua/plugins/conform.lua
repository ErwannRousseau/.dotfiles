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
        php_cs_fixer = {
          command = "docker",
          args = function(_, ctx)
            local config = vim.fs.find(".php-cs-fixer.dist.php", {
              path = ctx.dirname,
              upward = true,
              type = "file",
            })[1]
            local root = vim.fs.dirname(config)
            return {
              "run", "--rm", "-i", "-v", root .. ":/code", "-w", "/code",
              "docker-php-cs-fixer", "fix", "-",
            }
          end,
          cwd = function(_, ctx)
            local config = vim.fs.find(".php-cs-fixer.dist.php", { path = ctx.dirname, upward = true, type = "file" })[1]
            return vim.fs.dirname(config)
          end,
        },

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
