return {
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		current_line_blame = true, -- Show blame info at end of line

		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- Navigation between hunks
			map("n", "<C-l>", gs.next_hunk, "Next Git hunk")
			map("n", "<C-h>", gs.prev_hunk, "Prev Git hunk")

			-- Actions
			map("n", "<leader>gp", gs.preview_hunk, "Preview Git hunk")
			map("n", "<leader>gs", gs.stage_hunk, "Stage Git hunk")
			map("n", "<leader>gr", gs.reset_hunk, "Reset Git hunk")
			map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
			map("n", "<leader>gR", gs.reset_buffer)
			-- Blame
			map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle Git blame")

			-- Diff
			map("n", "<leader>gd", gs.diffthis, "Diff this file")
		end,
	},
}
