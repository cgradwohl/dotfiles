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
			css = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			python = { "isort", "black" },
			scss = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			yaml = { "prettier" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- format_on_save = { timeout_ms = 500 },
		-- Customize formatters
		formatters = {
			prettier = {
				prepend_args = function()
					local fname = vim.api.nvim_buf_get_name(0)
					if fname == "" then
						-- fallback: use a reasonable filename if buffer is unnamed
						fname = "file.md"
					end
					return { "--stdin-filepath", fname, "--config", vim.fn.expand("~/.config/nvim/.prettierrc.yaml") }
				end,
			},
		},
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
