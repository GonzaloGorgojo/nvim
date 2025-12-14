return {
	-- Treesitter for syntax highlighting, indentation, and text objects
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag", -- auto-close/rename HTML/JSX tags
		},
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				highlight = { enable = true }, -- code highlighting
				indent = { enable = true }, -- smart indentation
				folds = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						node_decremental = "grm",
						scope_incremental = "grc",
					},
				},
				ensure_installed = {
					"lua",
					"go",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"html",
					"css",
					"scss",
					"bash",
					"c",
					"diff",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"vim",
					"vimdoc",
					"prisma",
				},
				auto_install = true, -- automatically install missing parsers
			})
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					vim.opt_local.foldmethod = "expr"
					vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.opt_local.foldlevel = 99
					vim.opt_local.foldenable = true
				end,
			})

			require("nvim-ts-autotag").setup()
		end,
	},

	-- Sticky context: shows current function/class at the top of the window
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 1,
				min_window_height = 0,
				trim_scope = "outer",
				patterns = {
					default = { "class", "function", "method" },
					lua = { "function", "local_function" },
					go = { "func", "method_declaration" },
					javascript = { "function", "method", "class" },
					typescript = { "function", "method", "class" },
					tsx = { "function", "method", "class" },
				},
			})
		end,
	},
}
