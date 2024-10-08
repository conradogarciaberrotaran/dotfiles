local keymap = function(mode, keys, func, desc)
	vim.api.nvim_set_keymap(mode, keys, func, { noremap = true, silent = true, desc = desc })
end

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"kelly-lin/telescope-ag",
		"nvim-tree/nvim-web-devicons",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		-- or create your custom action

		telescope.setup({
			file_ignore_patterns = {
				".git/.*",
				".cache",
				"%.o",
				"%.a",
				"%.out",
				"%.class",
				"%.pdf",
				"%.mkv",
				"%.mp4",
				"%.zip",
				"*.lock",
			},
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
					},
				},

				cache_picker = { num_pickers = 10 },
				dynamic_preview_title = true,
				layout_strategy = "vertical",
				layout_config = { vertical = { width = 0.9, height = 0.9, preview_height = 0.6, preview_cutoff = 0 } },
				path_display = { "smart", shorten = { len = 3 } },
				wrap_results = true,
			},
			pickers = {
				find_files = {
					hidden = false,
				},
				-- Default configuration for builtin pickers goes here:
				-- picker_name = {
				--   picker_config_key = value,
				--   ...
			},
			-- Now the picker_config_key will be applied every time you call this
			-- builtin picker
			-- },
			extensions = {
				media_files = {
					-- filetypes whitelist
					-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
					filetypes = { "png", "webp", "jpg", "jpeg" },
					find_cmd = "ag", -- find command (defaults to `fd`)
				},
				-- Your extension configuration goes here:
				-- extension_name = {
				--   extension_config_key = value,
				-- }
				-- please take a look at the readme of the extension you want to configure
			},
			undo = {
				mappings = {
					i = {
						["<C-cr>"] = require("telescope-undo.actions").restore,
					},
				},
			},
		})
		require("telescope").load_extension("undo")
		keymap("n", "<leader>u", "<cmd>Telescope undo<cr>")

		-- Find files and live grep
		keymap(
			"n",
			"<C-p>",
			"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
			"Fuzzy file finder"
		)
		keymap("n", "<C-t>", "<cmd>lua require'telescope.builtin'.live_grep()<cr>", "Live grep")
	end,
}
