-- catppuccin
-- return {
--     "catppuccin/nvim",
--     lazy = false,
--     name = "catppuccin",
--     priority = 1000,
-- config = function()
--   vim.cmd([[colorscheme catppuccin]])
--
--   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end
--   }

-- eldritch
-- return {
--     "eldritch-theme/eldritch.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {},
--     config = function()
--         vim.cmd([[colorscheme eldritch]])
--     end
-- }
-- lua/plugins/rose-pine.lua
-- return {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine-dawn",
-- 	config = function()
-- 		vim.cmd("colorscheme rose-pine")
-- 	end,
-- }

-- return {
-- 	"morhetz/gruvbox",
-- 	name = "gruvbox-light",
-- 	config = function()
-- 		vim.o.background = "light"
-- 		vim.cmd("colorscheme gruvbox")
-- 	end,
-- }

return {
	"sainnhe/gruvbox-material",
	name = "gruvbox-material",
	config = function()
		-- Set background (light or dark)
		vim.o.background = "light" -- or "dark"

		-- Optional: set contrast (choices: 'hard', 'medium', 'soft')
		vim.g.gruvbox_material_background = "soft"

		-- Optional: enable true color support
		vim.o.termguicolors = true

		-- Load the colorscheme
		vim.cmd("colorscheme gruvbox-material")
	end,
}
