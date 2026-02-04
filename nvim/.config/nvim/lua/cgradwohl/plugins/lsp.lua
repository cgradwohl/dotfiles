return {
	"neovim/nvim-lspconfig",
	dependencies = {
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
	config = function()
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

		------------------------------------------------------------
		-- Server Configurations (using modern vim.lsp.config API)
		------------------------------------------------------------

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "Lua 5.1" },
					diagnostics = { globals = { "bit", "vim", "it", "describe", "before_each", "after_each" } },
				},
			},
		})

		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		})

		vim.lsp.config("eslint", {
			capabilities = capabilities,
			settings = { workingDirectories = { mode = "auto" } },
		})

		vim.lsp.config("tailwindcss", {
			capabilities = capabilities,
			filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			settings = {
				tailwindCSS = {
					experimental = {
						classRegex = {
							{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
							{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
						},
					},
				},
			},
		})

		vim.lsp.config("cssls", {
			capabilities = capabilities,
			settings = {
				css = { validate = true, lint = { unknownAtRules = "ignore" } },
				scss = { validate = true },
			},
		})

		vim.lsp.config("html", {
			capabilities = capabilities,
			filetypes = { "html", "htmldjango" },
		})

		vim.lsp.config("pyright", {
			capabilities = capabilities,
			settings = {
				python = {
					venvPath = ".",
					venv = "venv",
					pythonPath = "venv/bin/python",
					analysis = {
						autoSearchPath = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace",
						typeCheckingMode = "basic",
					},
				},
			},
		})

		vim.lsp.config("terraformls", {
			capabilities = capabilities,
			filetypes = { "terraform", "terraform-vars" },
		})

		vim.lsp.config("tofu_ls", {
			capabilities = capabilities,
			cmd = { "tofu-ls", "serve" },
			filetypes = { "terraform", "terraform-vars" },
			root_markers = { ".terraform", ".git" },
		})

		-- tofu-ls is not managed by Mason, enable it manually
		vim.lsp.enable("tofu_ls")

		vim.lsp.config("yamlls", {
			capabilities = capabilities,
			settings = {
				yaml = {
					schemas = {
						kubernetes = "k8s-*.yaml",
						["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
						["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
						["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
						["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
						["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
						["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
						["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
					},
					schemaStore = { enable = true },
					format = { enable = true },
				},
			},
		})

		-- Servers with default settings just need capabilities
		for _, server in ipairs({ "gopls", "tflint" }) do
			vim.lsp.config(server, { capabilities = capabilities })
		end

		------------------------------------------------------------
		-- Mason Setup (installs servers, automatic_enable handles the rest)
		------------------------------------------------------------

		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"cssls",
				"eslint",
				"gopls",
				"html",
				"lua_ls",
				"pyright",
				"tailwindcss",
				"terraformls",
				"tflint",
				"ts_ls",
				"yamlls",
			},
			automatic_enable = true, -- auto-enables servers via vim.lsp.enable()
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"black",
				"eslint_d",
				"isort",
				"mypy",
				"prettier",
				"ruff",
				"stylua",
			},
		})

		------------------------------------------------------------
		-- Autocommands
		------------------------------------------------------------

		-- ESLint auto-fix on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
			callback = function()
				vim.cmd("silent! EslintFixAll")
			end,
		})

		-- Terraform format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.tf", "*.tfvars" },
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})

		-- tofu-ls auto-format on save
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
				if client.name == "tofu_ls" and client:supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("tofu-ls", { clear = false }),
						buffer = args.buf,
						callback = function()
							vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
						end,
					})
				end
			end,
		})

		------------------------------------------------------------
		-- Completion Setup (nvim-cmp)
		------------------------------------------------------------

		require("luasnip.loaders.from_vscode").lazy_load()

		local cmp = require("cmp")
		local luasnip = require("luasnip")

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
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<Enter>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-f>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-b>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			formatting = {
				format = function(entry, vim_item)
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snip]",
						buffer = "[Buf]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
		})
	end,
}
