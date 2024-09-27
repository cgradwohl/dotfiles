local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo(
    { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

-- LazyVim Setup
require("lazy").setup({
  -- Imports base plugin list from here: https://github.com/AstroNvim/AstroNvim/tree/main/lua/astronvim/plugins
  {
    "AstroNvim/AstroNvim",
    version = "^4",                -- Remove version tracking to elect for nighly AstroNvim
    import = "astronvim.plugins",
    opts = {                       -- AstroNvim options must be set here with the `import` key
      mapleader = " ",             -- This ensures the leader key must be configured before Lazy is set up
      maplocalleader = ",",        -- This ensures the localleader key must be configured before Lazy is set up
      icons_enabled = true,        -- Set to false to disable icons (if no Nerd Font is available)
      pin_plugins = nil,           -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
      update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
    },
  },
  -- Imports local astrocommunity.lua file
  { import = "astrocommunity" },
  -- Imports local plugins lua module
  { import = "plugins" },
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  -- colorscheme that will be used when installing plugins
  install = { colorscheme = { "catppuccin" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])


-- Polish
-- Set up custom filetypes here
-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}
