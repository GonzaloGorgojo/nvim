return {
	{ -- Show CSS Colors
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},
	{ -- This helps with ssh tunneling and copying to clipboard
		"ojroques/vim-oscyank",
	},
	{
		"tpope/vim-sleuth",
	},
	{ -- Highlight todo, notes, etc in comments

		"folke/todo-comments.nvim",
		event = "VimEnter",
		bependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{ -- Collection of small plugins bundled together
		"nvim-mini/mini.nvim",
		version = "*",
		config = function()
			-- Better Around/Inside textobjects
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })
			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
			require("mini.comment").setup()
		end,
	},
}
