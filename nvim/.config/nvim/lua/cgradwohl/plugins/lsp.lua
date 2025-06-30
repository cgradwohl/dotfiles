return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		{ "L3MON4D3/LuaSnip" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rafamadriz/friendly-snippets" },
	},
	init = function()
		-- Reserve a space in the gutter
		-- This will avoid an annoying layout shift in the screen
		--
		-- NOTE: I added this to cgradwohl.vim
		-- vim.opt.signcolumn = 'yes'
	end,
	config = function()
		-- NOTE: I moved this to cgradwohl.vim
		-- vim.api.nvim_create_autocmd('LspAttach', {
		-- 	callback = function(event)
		-- 		local opts = {buffer = event.buf}
		--
		-- 		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		-- 		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		-- 		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		-- 		vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		-- 		vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		-- 		vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		-- 		vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		-- 		vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		-- 		vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		-- 		vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		-- 	end,
		-- })

		local lspconfig_defaults = require("lspconfig").util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig_defaults.capabilities,
			require("cmp_nvim_lsp").default_capabilities()
		)

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"gopls",
				"lua_ls",
				"pyright",
				"terraformls",
				"tflint",
				"yamlls",
			},
			automatic_enable = false,
			handlers = {
				-- this first function is the "default handler"
				-- it applies to every language server without a "custom handler"
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
				["pyright"] = function()
					require("lspconfig").pyright.setup({
						settings = {
							python = {
								venvPath = ".",
								venv = "venv",
								pythonPath = "venv/bin/python",
								analysis = {
									autoSearchPath = true,
									useLibraryCodeForTypes = true,
									diagnosticMode = "workspace", -- or "openFilesOnly" for faster performance
									typeCheckingMode = "basic", -- "off", "basic", or "strict"
								},
							},
						},
					})

					vim.api.nvim_create_autocmd("BufWritePre", {
						pattern = "*.py",
						callback = function()
							-- vim.lsp.buf.format({ async = false }) -- If using an LSP formatter
							-- Alternatively, use black directly:
							vim.cmd(":!black %")
						end,
					})
				end,
				["terraformls"] = function()
					require("lspconfig").terraformls.setup({
						-- ensures the LSP server attaches to both *.tf and *.tfvars buffers
						filetypes = { "terraform", "terraform-vars" },
					})
					-- Format *.tf and *.tfvars files on save
					vim.api.nvim_create_autocmd("BufWritePre", {
						pattern = { "*.tf", "*.tfvars" },
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end,
				["tflint"] = function()
					require("lspconfig").tflint.setup({})
				end,
				["yamlls"] = function()
					require("lspconfig").yamlls.setup({
						-- optionally tell yamlls to ignore jinja templating
						settings = {
							yaml = {
								schemaStore = { enable = true },
								format = { enable = true },
							},
						},
					})
				end,
			},
		})
		-- a convenient way of auto-installing/updating packages by using
		-- an ensure_installed table (which Mason doesn't provide) from the
		-- mason registry only
		require("mason-tool-installer").setup({
			ensure_installed = {
				"black",
				"eslint_d",
				"gopls",
				"isort",
				"mypy",
				"prettier",
				"pyright",
				"ruff",
				"stylua",
				"terraform-ls",
				"tflint",
			},
		})

		local lsp_zero = require("lsp-zero")

		local cmp = require("cmp")
		local cmp_action = lsp_zero.cmp_action()

		-- this is the function that loads the extra snippets
		-- from rafamadriz/friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			sources = {
				{ name = "nvim_lsp", priority = 1000 },
				{ name = "nvim_lsp_signature_help" },
				{ name = "luasnip", keyword_length = 2, priority = 750 },
				{ name = "buffer", keyword_length = 3, priority = 500 },
				{ name = "path", priority = 250 },
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- confirm completion item
				["<Enter>"] = cmp.mapping.confirm({ select = true }),

				-- trigger completion menu
				["<C-Space>"] = cmp.mapping.complete(),

				-- scroll up and down the documentation window
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),

				-- navigate between snippet placeholders
				["<C-f>"] = cmp_action.luasnip_jump_forward(),
				["<C-b>"] = cmp_action.luasnip_jump_backward(),
			}),
			-- note: if you are going to use lsp-kind (another plugin)
			-- replace the line below with the function from lsp-kind
			formatting = lsp_zero.cmp_format({ details = true }),
		})
	end,
}
