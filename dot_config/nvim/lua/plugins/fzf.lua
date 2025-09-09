return {
  "ibhagwan/fzf-lua",
  keys = function(_, keys)
    table.insert(keys, {
      "<leader>sx",
      function()
        require("fzf-lua").live_grep({
          cmd = "rg --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -F -e",
        })
      end,
      desc = "Grep fi[X]ed-strings)",
    })
    return keys
  end,
}
