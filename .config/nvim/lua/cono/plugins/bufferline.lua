return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
		},
	},
	config = function()
		require("bufferline").setup({
			options = {
				close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
				middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
				indicator = { style = "icon", icon = "" },
				modified_icon = "-",
				show_close_icon = false,
				offsets = {
					{ filetype = "NvimTree" },
				},
				show_tab_indicators = true,
				show_buffer_close_icons = false,
			},
			highlights = require("catppuccin.groups.integrations.bufferline").get(),
		})
	end,
}
