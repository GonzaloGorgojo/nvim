return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			-- Customize the settings if necessary
			view = {
				-- width = 30, -- Set the width of the file tree
				-- side = "right",
				float = {
					enable = true,
					open_win_config = {
						relative = "editor",
						height = vim.o.lines - 4,
						width = 45,
						col = 0,
						row = 0,
					},
				},
			},
			renderer = {
				highlight_opened_files = "name", -- Highlight opened files in the tree
				highlight_git = true,
				icons = {
					show = {
						git = true, -- Show git icons
						folder = true, -- Show folder icons
						file = true, -- Show file icons
					},
				},
			},
			update_focused_file = {
				enable = true, -- automatically focuses the current file in tree
				update_cwd = true, -- optionally update the tree's root to the current buffer's directory
				ignore_list = {}, -- files to ignore
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
				custom = {},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true, -- only show on files
				show_on_open_dirs = true,
				debounce_delay = 50,
				icons = {
					hint = "󰌶 ",
					info = "󰋽 ",
					warning = "󰀪 ",
					error = "󰅚 ", -- errors will make file names red
				},
			},
		})
	end,
}
