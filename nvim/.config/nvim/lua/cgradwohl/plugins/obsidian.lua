return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter"
    },
    opts = {
        workspaces = {
            {
                name = 'Notes',
                path = '/Users/CGradwohl/CGradwohl/NoteBox',
            }
        },

        -- see below for full list of options 👇
    },
}
