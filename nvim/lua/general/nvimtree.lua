local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
	update_cwd = false,
	filters = {
		dotfiles = true,
		custom = { "__pycache__" },
	},
	view = {
		mappings = {
			list = {
				{ key = "h", cb = tree_cb("toggle_dotfiles") },
			},
		},
	},
})
