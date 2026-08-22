return {
  "ibhagwan/fzf-lua",
  opts = {
    grep = {
      follow = true,
    },
  },
  keys = function(_, keys)
    table.insert(keys, {
      "<leader>sx",
      function()
        require("fzf-lua").live_grep({
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -F -e",
        })
      end,
      desc = "Grep fi[X]ed-strings)",
    })
    return keys
  end,
}
