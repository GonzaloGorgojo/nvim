vim.g.mapleader = " " --set space as leader
--NORMAL MODE KEYMAPS--
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<C-q>", "<cmd>bp|bd #<CR>", { desc = "Close current buffer and go to previous" })
vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>bd", ":bufdo bdelete<CR>", { desc = "Close all buffers" })

-- Normal mode: jump 10 lines with Ctrl + Down / Ctrl + Up
vim.keymap.set("n", "<M-Down>", "10j", { noremap = true, silent = true, desc = "Jump 10 lines down" })
vim.keymap.set("n", "<M-Up>", "10k", { noremap = true, silent = true, desc = "Jump 10 lines Up" })
-- Visual mode (optional)
vim.keymap.set("v", "<M-Down>", "10j", { noremap = true, silent = true, desc = "Jump 10 lines down" })
vim.keymap.set("v", "<M-Up>", "10k", { noremap = true, silent = true, desc = "Jump 10 lines up" })

--FILE TREE--
vim.api.nvim_set_keymap(
	"n",
	"<leader>e",
	":NvimTreeToggle<CR>",
	{ noremap = true, silent = true, desc = "Toogle file tree" }
)

--DIAGNOSTICS--
vim.api.nvim_set_keymap(
	"n",
	"<leader>sd",
	":lua vim.diagnostic.open_float(0, {scope='line', border='rounded'})<CR>",
	{ noremap = true, silent = true, desc = "Show diagnostic on current line" }
)
