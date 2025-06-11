return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod

		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")

		-- or create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function(prompt_bufnr)
				trouble.toggle("quickfix")
			end,
		})

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = trouble_telescope.open,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		-- Git-related keymaps (only if git is executable)
		if vim.fn.executable("git") == 1 then
			keymap.set("n", "<leader>gb", function()
				require("telescope.builtin").git_branches({ use_file_path = true })
			end, { desc = "Git branches" })

			keymap.set("n", "<leader>gc", function()
				require("telescope.builtin").git_commits({ use_file_path = true })
			end, { desc = "Git commits (repository)" })

			keymap.set("n", "<leader>gC", function()
				require("telescope.builtin").git_bcommits({ use_file_path = true })
			end, { desc = "Git commits (current file)" })

			keymap.set("n", "<leader>gt", function()
				require("telescope.builtin").git_status({ use_file_path = true })
			end, { desc = "Git status" })
		end

		-- General Telescope keymaps
		keymap.set("n", "<leader>f<CR>", "<cmd>Telescope resume<cr>", { desc = "Resume previous search" })
		keymap.set("n", "<leader>f'", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
		keymap.set(
			"n",
			"<leader>f/",
			"<cmd>Telescope current_buffer_fuzzy_find<cr>",
			{ desc = "Find words in current buffer" }
		)

		keymap.set("n", "<leader>fa", function()
			require("telescope.builtin").find_files({
				prompt_title = "Config Files",
				cwd = vim.fn.stdpath("config"),
				follow = true,
			})
		end, { desc = "Find AstroNvim config files" })

		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor" })
		keymap.set("n", "<leader>fC", "<cmd>Telescope commands<cr>", { desc = "Find commands" })
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })

		keymap.set("n", "<leader>fF", function()
			require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
		end, { desc = "Find all files" })

		keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find git files" })
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })
		keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
		keymap.set("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { desc = "Find man pages" })

		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

		keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Find history" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Find registers" })

		keymap.set("n", "<leader>ft", function()
			require("telescope.builtin").colorscheme({ enable_preview = true, ignore_builtins = true })
		end, { desc = "Find themes" })

		-- Live Grep (only if ripgrep is executable)
		if vim.fn.executable("rg") == 1 then
			keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find words" })

			keymap.set("n", "<leader>fW", function()
				require("telescope.builtin").live_grep({
					additional_args = function(_args)
						return { "--hidden", "--no-ignore" }
					end,
				})
			end, { desc = "Find words in all files" })
		end

		-- LSP and diagnostics
		keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics<cr>", { desc = "Search diagnostics" })
	end,
}
