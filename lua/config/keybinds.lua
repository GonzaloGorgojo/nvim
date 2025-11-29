vim.g.mapleader = " " --set space as leader
--NORMAL MODE KEYMAPS--
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save ([W]rite) file" })
vim.keymap.set("n", "<leader>kk", vim.lsp.buf.hover, { desc = "LSP Hover" })

-- Window navigation with Shift + hjkl
vim.keymap.set("n", "<S-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<S-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<S-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<S-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- jump 10 lines
vim.keymap.set("n", "<M-Down>", "10j", { noremap = true, silent = true, desc = "Jump 10 lines down" })
vim.keymap.set("n", "<M-Up>", "10k", { noremap = true, silent = true, desc = "Jump 10 lines Up" })
vim.keymap.set("v", "<M-Down>", "10j", { noremap = true, silent = true, desc = "Jump 10 lines down" })
vim.keymap.set("v", "<M-Up>", "10k", { noremap = true, silent = true, desc = "Jump 10 lines up" })
vim.keymap.set("n", "<M-j>", "10j", { noremap = true, silent = true, desc = "Jump 10 lines down" })
vim.keymap.set("n", "<M-k>", "10k", { noremap = true, silent = true, desc = "Jump 10 lines Up" })
vim.keymap.set("v", "<M-j>", "10j", { noremap = true, silent = true, desc = "Jump 10 lines down" })
vim.keymap.set("v", "<M-k>", "10k", { noremap = true, silent = true, desc = "Jump 10 lines up" })

-- Move Lines up/down
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi")

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

vim.keymap.set("n", "<C-q>", ":bd<CR>", { desc = "Delete current buffer" })
