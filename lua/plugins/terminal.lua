return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 12, -- Terminal height
			direction = "horizontal", -- Opens at bottom
			persist_mode = true, -- Keeps terminal session running
			shade_terminals = true, -- Dim background slightly
			start_in_insert = true, -- Open in Insert mode (optional)
		})
		local Terminal = require("toggleterm.terminal").Terminal
		local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })

		function _lazydocker_toggle()
			lazydocker:toggle()
		end

		vim.keymap.set("n", "<leader>d", _lazydocker_toggle, { desc = "Toggle Lazydocker (float)" })

		vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
		vim.keymap.set("n", "<leader>vt", "<cmd>:2ToggleTerm<CR>", { desc = "Create second terminal vertical" })
		vim.keymap.set("n", "<leader>ft", function()
			require("toggleterm").toggle(3, nil, nil, "float")
		end, { desc = "Toggle floating terminal #3" })
		vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
	end,
}
