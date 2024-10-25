require("cgradwohl.core")

require("lazy").setup({
  spec = {
    { import = "cgradwohl.plugins" },
  },
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
