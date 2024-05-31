return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local bufmap = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
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

				vim.api.nvim_buf_create_user_command(ev.buf, "Format", function(_)
					vim.lsp.buf.format({ async = true })
				end, {})
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
