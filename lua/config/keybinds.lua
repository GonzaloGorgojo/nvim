vim.g.mapleader = " " --set space as leader
--NORMAL MODE KEYMAPS--
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<C-q>", "<cmd>bp|bd #<CR>", { desc = "Close current buffer and go to previous" })
vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save ([W]rite) file" })

-- jump 10 lines with Ctrl + Down / Ctrl + Up
vim.keymap.set("n", "<M-Down>", "10j", { noremap = true, silent = true, desc = "Jump 10 lines down" })
vim.keymap.set("n", "<M-Up>", "10k", { noremap = true, silent = true, desc = "Jump 10 lines Up" })
vim.keymap.set("v", "<M-Down>", "10j", { noremap = true, silent = true, desc = "Jump 10 lines down" })
vim.keymap.set("v", "<M-Up>", "10k", { noremap = true, silent = true, desc = "Jump 10 lines up" })

-- jump 10 lines with Ctrl + Down / Ctrl + Up
vim.keymap.set("n", "<M-j>", "10j", { noremap = true, silent = true, desc = "Jump 10 lines down" })
vim.keymap.set("n", "<M-k>", "10k", { noremap = true, silent = true, desc = "Jump 10 lines Up" })
vim.keymap.set("v", "<M-j>", "10j", { noremap = true, silent = true, desc = "Jump 10 lines down" })
vim.keymap.set("v", "<M-k>", "10k", { noremap = true, silent = true, desc = "Jump 10 lines up" })

-- Move Lines up/down
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })

--Open FILE TREE--
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
