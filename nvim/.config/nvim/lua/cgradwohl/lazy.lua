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


require("lazy").setup({
    spec = {
        { import = "cgradwohl.astro" },
        { import = "cgradwohl.plugins" },
    },
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "catppuccin" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
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
    }
})
