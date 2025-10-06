return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				layout_strategy = "flex", -- 👈 key: flex adapts automatically
				layout_config = {
					horizontal = {
						preview_width = 0.55, -- preview takes ~55% width
					},
					vertical = {
						preview_height = 0.4, -- preview takes ~40% height
					},
					flex = {
						flip_columns = 120, -- 👈 switch to vertical if width < 120 cols
					},
				},
				file_ignore_patterns = { "node_modules", ".git/" }, -- still ignore noisy dirs
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", function()
			builtin.find_files({ hidden = true })
		end, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set("n", "<leader>lD", builtin.diagnostics, { desc = "[L]SP workspace diagnostics" })
		vim.keymap.set("n", "<leader>ld", function()
			builtin.diagnostics({ bufnr = 0 })
		end, { desc = "[L]SP buffer diagnostics" })
		vim.keymap.set("n", "<C-Tab>", function()
			builtin.buffers({
				sort_mru = true,
				ignore_current_buffer = true,
				show_all_buffers = false,
				previewer = false,
				theme = "dropdown",
				layout_config = { width = 0.4 },
				mappings = {
					i = {
						["<CR>"] = "select_default", -- Enter to open
						["<Tab>"] = "move_selection_next", -- Tab to move down
						["<S-Tab>"] = "move_selection_previous", -- Shift-Tab to move up
					},
					n = {
						["<CR>"] = "select_default",
						["<Tab>"] = "move_selection_next",
						["<S-Tab>"] = "move_selection_previous",
					},
				},
			})
		end, { desc = "Switch buffers (MRU order like VSCode)" })
		vim.keymap.set("n", "<leader>fgc", function()
			builtin.live_grep({
				grep_open_files = false,
				search_dirs = vim.fn.systemlist("git diff --name-only"),
				prompt_title = "Live Grep in Git Changed Files",
			})
		end, { desc = "Search in [G]it [C]hanged files" })

		-- Or: just fuzzy-find filenames of changed files
		vim.keymap.set("n", "<leader>fc", function()
			builtin.find_files({
				find_command = { "git", "diff", "--name-only" },
				prompt_title = "Find Git Changed Files",
			})
		end, { desc = "[S]earch [F]iles [C]hanged" })

		--GIT TELESCOPE--
		vim.keymap.set("n", "<leader>sc", function()
			builtin.git_status()
		end, { desc = "[S]how git status" })

		vim.keymap.set("n", "<leader>ss", function()
			builtin.git_stash()
		end, { desc = "[S]how git stashs" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find()
		end, { desc = "[/] Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
