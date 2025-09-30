vim.opt.number = true -- numbers on lines
vim.opt.cursorline = true --show the line that im in with color
vim.opt.relativenumber = true --relative numbers on lines to jump
vim.opt.shiftwidth = 4 --next line after enter got identation of 4 spaces
vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.showbreak = "↳ " --show this in next line when wrapping lines
vim.opt.signcolumn = "yes" -- Keep signcolumn(left column for errors, etc) on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 500 -- Decrease mapped sequence wait time
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.scrolloff = 15 -- Minimal number of screen lines to keep above and below the cursor.

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣"}

-- Folding settings
vim.opt.foldmethod = "expr" -- Use Treesitter for folds
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99 -- Start with all folds open
vim.opt.foldenable = true -- Enable folding globally
