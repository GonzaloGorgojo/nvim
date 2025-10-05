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
	end,
}
