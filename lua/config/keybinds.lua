vim.g.mapleader = " " --set space as leader
--NORMAL MODE KEYMAPS--
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex) --go to folder from file
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<C-q>", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-Tab>", ":bnext<CR>", { desc = "Switch to next buffer" })
vim.keymap.set("n", "<C-S-Tab>", ":bprev<CR>", { desc = "Switch to previous buffer" })

--TERMINAL--
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--FILE TREE--
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

--DIAGNOSTICS--
vim.api.nvim_set_keymap(
	"n",
	"<leader>sd",
	":lua vim.diagnostic.open_float(0, {scope='line', border='rounded'})<CR>",
	{ noremap = true, silent = true }
)
