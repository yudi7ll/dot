-- Automatically set filetype to tmux for .conf files in this directory
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.conf",
  callback = function()
    vim.bo.filetype = "tmux"
    vim.bo.syntax = "tmux"
  end,
})
