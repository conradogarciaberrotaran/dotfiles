local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	sources = {
		-- JS
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		-- Python
		-- formatting.black.with({ extra_args = { "--fast" } }),
		-- formatting.isort.with({ extra_args = { "--profile black" } }),
		formatting.ruff.with({
			extra_args = { "--unfixable", "F401,F841" },
		}),
		diagnostics.ruff,
		-- Lua
		formatting.stylua,
		-- Rust
		formatting.rustfmt,
	},
	-- Enables auto format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
