local on_attach = function(_, bufnr)
	local bufmap = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- Go to declaration
	bufmap("<leader>g", vim.lsp.buf.declaration, "Go to declaration")

	-- Go to definition
	bufmap("<leader>d", vim.lsp.buf.definition, "Go to definition")

	-- Show information on current object
	bufmap("K", vim.lsp.buf.hover, "Show information")

	-- See all references
	bufmap("gr", require("telescope.builtin").lsp_references, "See al references")

	-- Rename all references
	bufmap("<leader>r", vim.lsp.buf.rename, "Rename all references")

	-- Code actions
	bufmap("<leader>ca", vim.lsp.buf.code_action, "Code actions")

	-- Show diagnostics
	bufmap("gl", vim.diagnostic.open_float, "Show diagnostics")

	-- Go to previous warning / error
	bufmap("<C-k>", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', "Go to next error")
	bufmap("<C-j>", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', "Go to previous error")

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local diagnostics_setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

require("mason").setup()
require("mason-lspconfig").setup_handlers({

	function(server_name)
		diagnostics_setup()
		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,

	["pylsp"] = function()
		require("lspconfig").pylsp.setup({
			on_attach = on_attach,
			settings = {
				pylsp = {
					plugins = {
						pyflakes = { enabled = false },
						pycodestyle = { enabled = false },
					},
				},
			},
		})
	end,
	["lua_ls"] = function()
		require("neodev").setup()
		require("lspconfig").lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})
	end,
})
