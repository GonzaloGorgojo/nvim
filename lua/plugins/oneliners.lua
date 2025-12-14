return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- load at startup
		priority = 1000, -- ensure colorscheme loads first
		config = function()
			require("tokyonight").setup({
				style = "night", -- or "night", "daA"
				transparent = true, -- makes background transparent
				terminal_colors = true, -- match terminal colors
				styles = {
					-- sidebars = "transparent",
					-- floats = "transparent",
				},
			})
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sections = {
				lualine_c = {
					{ "filename", path = 1, separator = " " },
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
						color = { fg = "#ff9e64" },
					},
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
						color = { fg = "#ff9e64" },
					},
				},
			},
			options = {
				refresh = {
					statusline = 1000,
					events = {
						"WinEnter",
						"BufEnter",
						"BufWritePost",
						"SessionLoadPost",
						"FileChangedShellPost",
						"VimResized",
						"Filetype",
						"ModeChanged",
					},
				},
				icons_enabled = true,
				theme = "tokyonight",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = true,
			},
		},
	},
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
		dependencies = { "nvim-lua/plenary.nvim" },
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
			require("mini.ai").setup({ n_lines = 50 })
			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
			require("mini.comment").setup()
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
		opts = {
			completions = {
				lsp = { enabled = true },
			},
		},
	},
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		opts = {
			copilot_node_command = vim.fn.expand("~/.nvm/versions/node/v22.17.1/bin/node"),
			suggestion = { enabled = false }, -- disable ghost-text
			panel = { enabled = false },
		},
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			interactions = {
				chat = {
					tools = {
						opts = {
							default_tools = {
								"full_stack_dev",
							},
							system_prompt = {
								enabled = true,
							},
						},
					},
				},
			},
		},
	},
}
