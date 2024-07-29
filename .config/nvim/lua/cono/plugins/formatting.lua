return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "ruff_lsp" },
				rust = { "rustfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				filter = function(client)
					if vim.bo.ft == "python" then
						return client.name ~= "ruff_lsp"
					end
					return false
				end,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				if vim.bo.ft == "python" then
					vim.lsp.buf.code_action({
						context = { only = { "source.fixAll.ruff" } },
						apply = true,
					})
				end
			end,
		})
	end,
}
