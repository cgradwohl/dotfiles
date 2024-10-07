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
        ["~/.kube/config"] = "yaml",
    },
    pattern = {
        ["~/%.config/foo/.*"] = "fooscript",
    },
}

vim.opt.conceallevel = 1
vim.opt.textwidth = 80
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
