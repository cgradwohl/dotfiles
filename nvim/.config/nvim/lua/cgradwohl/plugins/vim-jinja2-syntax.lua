return {
	-- Jinja2 syntax for plain Vim highlighting
	{
		"Glench/Vim-Jinja2-Syntax",
		ft = { "jinja", "htmldjango" },
		-- ensure it's loaded before your filetype autocmd
		lazy = false,
	},

	-- if you use nvim-treesitter and want injection
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "yaml", "jinja" },
			highlight = {
				enable = true,
				-- make sure both regex & treesitter work
				additional_vim_regex_highlighting = { "jinja" },
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- optional: polyglot for everything
	-- {
	--   "sheerun/vim-polyglot",
	--   lazy = true,
	--   ft = { "jinja", "yaml", "yml", "html" },
	-- },
}
