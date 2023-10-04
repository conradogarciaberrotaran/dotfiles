return {

    -- Theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    mason = true,
                    telescope = {
                        enabled = true,
                    },
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                        },
                        inlay_hints = {
                            background = true,
                        },
                    },
                }
            })
            vim.cmd("colorscheme catppuccin-mocha")
        end

    },

    -- Telescope with Silver Searcher and Zoxide
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kelly-lin/telescope-ag",
            "jvgrootveld/telescope-zoxide",

        }
    },

    -- Nvim Tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("nvim-tree").setup({
                update_cwd = false,
                filters = {
                    dotfiles = true,
                    custom = { "__pycache__" },
                },
            })
        end
    },

    -- Treesitter
    "nvim-treesitter/nvim-treesitter",

    -- Git
    "lewis6991/gitsigns.nvim",

    -- Bufferline
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        }
    },

    -- Bufdelete, use :Bdelete instead of :bdelete
    "famiu/bufdelete.nvim",

    -- Blankline
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end
    },


    -- Highlighted yank
    { "machakann/vim-highlightedyank" },

    -- Comfortable motion
    { "yuttie/comfortable-motion.vim" },

    -- Automatic python virtualenv management
    { "sansyrox/vim-python-virtualenv" },

    -- LSP Installer
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Enables LSP
    "neovim/nvim-lspconfig",

    -- Code completion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',

            'hrsh7th/cmp-nvim-lsp',

        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },

    -- Lua nvim configuration
    { "folke/neodev.nvim", opts = {} },
}
