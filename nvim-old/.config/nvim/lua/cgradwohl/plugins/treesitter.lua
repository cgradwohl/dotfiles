return { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
            ensure_installed = {
                'bash',
                'c',
                "c_sharp",
                'diff',
                "go",
                "gomod",
                "gosum",
                'html',
                'kotlin',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'python',
                'query',
                'scala',
                'sql',
                'typescript',
                'vim',
                'vimdoc',
                'yaml'
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        })
    end
}
