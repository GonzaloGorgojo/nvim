-- disable netrw to use nvim.tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- disable perl and ruby for now
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.opt.number = true -- numbers on lines
vim.opt.cursorline = true --show the line that im in with color
vim.opt.relativenumber = true --relative numbers on lines to jump
vim.opt.shiftwidth = 4 --next line after enter got identation of 4 spaces
vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.showbreak = "↳ " --show this in next line when wrapping lines
vim.opt.wrap = false --wrap lines in next line or not
vim.opt.signcolumn = "yes" -- Keep signcolumn(left column for errors, etc) on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 500 -- Decrease mapped sequence wait time
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.scrolloff = 15 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.autoread = true --if another program changes the file auto reload that
vim.opt.swapfile = false --disable swap files that are created to protect for multi editing same file or crashes but hit performance

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

-- wrap all floating previews with rounded border
local orig_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_floating_preview(contents, syntax, opts, ...)
end

-- Sets how neovim will display certain whitespace characters in the editor.
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣"}

-- Auto-display images in WezTerm new window using imgcat
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.bmp", "*.svg" },
	callback = function()
		local file = vim.fn.expand("%:p")
		-- Open new window with imgcat
		vim.fn.system(
			'wezterm cli spawn --new-window -- sh -c "wezterm imgcat '
				.. vim.fn.shellescape(file)
				.. "; echo; echo 'Press any key to close...'; read -n1\""
		)
		-- Close the buffer with binary content and go back to previous buffer
		vim.cmd("bdelete!")
	end,
})
