-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- thanks ThePrimeagen
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = false
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80 -- auto wrap while typing
vim.opt.conceallevel = 1

-- FOLDING
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 1

function NavigateFold(direction)
	local cmd = "normal! " .. direction
	local view = vim.fn.winsaveview()
	local lnum = view.lnum
	local new_lnum = lnum
	local open = true

	while lnum == new_lnum or open do
		vim.cmd(cmd)
		new_lnum = vim.fn.line(".")
		open = vim.fn.foldclosed(new_lnum) < 0
	end

	if open then
		vim.fn.winrestview(view)
	end
end

vim.keymap.set("n", "zj", function()
	NavigateFold("j")
end, { buffer = true })
vim.keymap.set("n", "zk", function()
	NavigateFold("k")
end, { buffer = true })

-- thanks ThePrimeagen
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
-- move blocks of text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- keep cursor put with J, C-d, C-u, n, N
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- delete highlighted word into black hole register, then paste
vim.keymap.set("x", "<leader>p", [["_dP]])
-- yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- delete to black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
-- Q is the worst
vim.keymap.set("n", "Q", "<nop>")
-- use tmux to switch to another session from vim!
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- format file by lsp, this conflicts with my telescope config
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)
-- quick fix list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- replace the current highlighted word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- make a bash script executable from vim!
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=terraform]])
-- vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

-- File Types
-- vim.filetype.add({
-- 	extension = {
-- 		tfvars = "terraform-vars",
-- 	},
-- })

-- Add OpenTofu filetype for .tofu files
vim.filetype.add({
	extension = {
		tofu = "opentofu",
	},
})

-- force *.yml.j2 to be treated as plain yaml
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.yml.j2", "*.yaml.j2", "*.yaml.tpl", "*.yml.tpl", "*.yaml.gotmpl", "*.yml.gotmpl" },
	callback = function(ctx)
		vim.bo[ctx.buf].filetype = "yaml"
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		-- Use direct Lua functions for consistency and performance
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Show hover documentation" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Go to definition" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "Go to declaration" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = event.buf, desc = "Go to implementation" })
		vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { buffer = event.buf, desc = "Go to type definition" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = event.buf, desc = "Jump to next diagnostic" })
		vim.keymap.set(
			"n",
			"[d",
			vim.diagnostic.goto_prev,
			{ buffer = event.buf, desc = "Jump to previous diagnostic" }
		)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = event.buf, desc = "Show references" })
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "Show signature help" })
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename symbol" })
		vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Show code actions" })
		vim.keymap.set({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end, { buffer = event.buf, desc = "Format buffer" })

		-- Leader-based keybindings (consistent with above)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename variable" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Show code actions" })
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("ThePrimeagen", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 80,
		})
	end,
})

-- format on save
-- use conform to format-on-save only for MD and YAML
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.md", "*.markdown", "*.yml", "*.yaml" },
	callback = function(args)
		require("conform").format({
			bufnr = args.buf,
			async = false, -- format synchronously before the write completes
			lsp_format = "fallback", -- use LSP only if no external formatter configured
			timeout_ms = 1500, -- raise if your formatter is slow
		})
	end,
})
