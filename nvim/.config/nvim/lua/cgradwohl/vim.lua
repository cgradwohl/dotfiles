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

vim.opt.number = true             -- optional - helps visually verify that it's working
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.wrap = true
vim.opt.linebreak = true          -- optional - breaks by word rather than character
vim.opt.columns = 80              -- this is the important part
