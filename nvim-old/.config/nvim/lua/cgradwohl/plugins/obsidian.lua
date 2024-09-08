return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
        -- refer to `:h file-pattern` for more examples
        "BufReadPre /Users/CGradwohl/CGradwohl/NoteBox/*.md",
        "BufNewFile /Users/CGradwohl/CGradwohl/NoteBox/*.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = 'Notes',
                path = '/Users/CGradwohl/CGradwohl/NoteBox',
            }
        },
    },
}
