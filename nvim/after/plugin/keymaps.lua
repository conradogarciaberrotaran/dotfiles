-- Shorten function name
local keymap = function(mode, keys, func, desc)
	vim.api.nvim_set_keymap(mode, keys, func, { noremap = true, silent = true, desc = desc })
end

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

-- Navigate buffers
keymap("n", "<leader>q", ":BufferLineCyclePrev<CR>", "Previous buffer")
keymap("n", "<leader>w", ":BufferLineCycleNext<CR>", "Next buffer")
keymap("n", "<leader>x", ":Bdelete<CR>", "Close buffer")

-- Clear search highlight
keymap("n", "<leader> ", ":noh<CR>", "Clear highlight")

-- CTRL+[hjkl] to jump to vertical/horizontal split
keymap("n", "<C-h>", "<C-w>h", "Left panel")
keymap("n", "<C-j>", "<C-w>j", "Bottom panel")
keymap("n", "<C-k>", "<C-w>k", "Top panel")
keymap("n", "<C-l>", "<C-w>l", "Right panel")

-- (temporary) CTRL+n Open Left explorer
keymap("n", "<C-n>", ":NvimTreeToggle<cr>", "Toggle file tree")

-- Find files and live grep
keymap(
	"n",
	"<C-p>",
	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
	"Fuzzy file finder"
)
keymap("n", "<C-t>", "<cmd>lua require'telescope.builtin'.live_grep()<cr>", "Live grep")
-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", "Resize up")
keymap("n", "<C-Down>", ":resize +2<CR>", "Resize down")
keymap("n", "<C-Left>", ":vertical resize +2<CR>", "Resize left")
keymap("n", "<C-Right>", ":vertical resize -2<CR>", "Resize right")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", "")
keymap("v", ">", ">gv", "")

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", "Move text up")
keymap("v", "<A-k>", ":m .-2<CR>==", "Move text down")

-- Keep yanked buffer after pasting
keymap("v", "p", '"_dP', "Keep yanked after pasting")

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", "Move text down")
keymap("x", "K", ":move '<-2<CR>gv-gv", "Move text up")

-- Fix common typos
vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev W1 w!
    cnoreabbrev w1 w!
    cnoreabbrev Q! q!
    cnoreabbrev Q1 q!
    cnoreabbrev q1 q!
    cnoreabbrev Qa! qa!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wa wa
    cnoreabbrev Wq wq
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev wq1 wq!
    cnoreabbrev Wq1 wq!
    cnoreabbrev wQ1 wq!
    cnoreabbrev WQ1 wq!
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qa qa
    cnoreabbrev Qall qall
]])

-- Disable annoying command history popup
keymap("n", "q:", "<nop>", "Disable command history")

-- Add format command
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])

-- Open zoxide directories
local t = require("telescope")
vim.keymap.set("n", "<leader>cd", t.extensions.zoxide.list)
