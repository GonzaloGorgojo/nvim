return {
	-- Adds git-related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged_enable = true,
		current_line_blame = true, -- Show blame info at end of line
		watch_gitdir = { follow_files = true },
		auto_attach = true,
		attach_to_untracked = false,
		update_debounce = 100,
	},

	config = function(_, opts)
		local gitsigns = require("gitsigns")
		gitsigns.setup(opts)

		-- Keymaps for git hunk actions
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { desc = desc })
		end

		map("n", "<C-l>", gitsigns.next_hunk, "Next Git hunk")
		map("n", "<C-h>", gitsigns.prev_hunk, "Prev Git hunk")
		map("n", "<leader>gp", gitsigns.preview_hunk, "Preview Git hunk")
		map("n", "<leader>gs", gitsigns.stage_hunk, "Stage Git hunk")
		map("n", "<leader>gr", gitsigns.reset_hunk, "Reset Git hunk")
		map("n", "<leader>gu", gitsigns.undo_stage_hunk, "Undo stage hunk")
		map("n", "<leader>gR", gitsigns.reset_buffer, "Reset all changes in current buffer")
		map("n", "<leader>gb", gitsigns.toggle_current_line_blame, "Toggle Git blame")
		map("n", "<leader>gd", gitsigns.diffthis, "Diff this file")
	end,
}
