-- https://lazy.folke.io/spec/lazy_loading#-colorschemes
return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    -- load the colorscheme here
    vim.cmd([[colorscheme catppuccin]])
  end
}
