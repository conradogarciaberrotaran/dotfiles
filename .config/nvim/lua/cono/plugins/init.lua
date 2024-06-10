return {
	"nvim-lua/plenary.nvim",
	"famiu/bufdelete.nvim",
	"machakann/vim-highlightedyank",
	"yuttie/comfortable-motion.vim",
	"sansyrox/vim-python-virtualenv",
	"avanzzzi/behave.vim",
	{
		"petobens/poet-v",
		config = function()
			vim.api.nvim_create_autocmd("VimEnter", {
				pattern = "*",
				command = "PoetvActivate",
			})
		end,
	},
}
