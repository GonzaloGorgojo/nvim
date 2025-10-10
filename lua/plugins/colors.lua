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
			theme = "tokyonight", -- match colorscheme
			options = {
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = true,
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			renderer = {
				highlight_opened_files = "all",
				highlight_git = true,
			},
			view = {
				width = 30,
				side = "left",
			},
			filters = {
				dotfiles = false,
			},
		},
		config = function(_, opts)
			require("nvim-tree").setup(opts)
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function() end,
	},
}
