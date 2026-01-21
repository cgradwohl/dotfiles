return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"css",
				"elixir",
				"go",
				"hcl",
				"heex",
				"html",
				"javascript",
				"jinja",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"markdown_inline",
				"query",
				"scss",
				"terraform",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = false },
		})
	end,
}
