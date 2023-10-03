nvim_tree = require("nvim-tree")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
	update_cwd = false,
	filters = {
		dotfiles = true,
		custom = { "__pycache__" },
	},
})
