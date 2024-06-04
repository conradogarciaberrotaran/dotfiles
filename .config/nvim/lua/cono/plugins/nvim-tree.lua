local keymap = function(mode, keys, func, desc)
	vim.api.nvim_set_keymap(mode, keys, func, { noremap = true, silent = true, desc = desc })
end

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 35,
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = {
					".DS_Store",
					".git",
					"*.pytest_cache",
					"__pycache__",
					".python-version",
					"log.txt",
					".ruff_cache",
					".coverage",
					"reports",
				},
			},
			git = {
				ignore = false,
			},
		})

		-- (temporary) CTRL+n Open Left explorer
		keymap("n", "<C-n>", ":NvimTreeToggle<cr>", "Toggle file tree")
	end,
}
