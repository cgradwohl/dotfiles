return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>mf",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            javascript = { "prettier" },
            typescript = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            lua = { "stylua" },
            python = { "isort", "black" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = { timeout_ms = 500 },
        -- Customize formatters
        formatters = {
            prettier = {
                prepend_args = function()
                    return {
                        "--write",
                        "--config",
                        string.format('%s', vim.fn.expand('~/.config/nvim/.prettierrc'))
                    }
                end
            }
        }
        -- prettierd = {
        -- env = {
        -- PRETTIERD_DEFAULT_CONFIG = string.format('%s',
        -- vim.fn.expand('~/.config/nvim/.prettierrc.yaml')),
        -- },
        -- },
    },
    -- init = function()
    -- If you want the formatexpr, here is the place to set it
    -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    -- end,
}
