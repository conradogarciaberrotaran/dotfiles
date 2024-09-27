return {
	"nvim-lua/plenary.nvim",
	"famiu/bufdelete.nvim",
	"machakann/vim-highlightedyank",
	"yuttie/comfortable-motion.vim",
	"sansyrox/vim-python-virtualenv",
	{
		"tzachar/highlight-undo.nvim",
		config = function()
			require("highlight-undo").setup()
		end,
	},
}
