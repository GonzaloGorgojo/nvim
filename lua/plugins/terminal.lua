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
    end,
}
