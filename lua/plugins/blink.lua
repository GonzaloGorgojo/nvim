return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
		{
			"fang2hou/blink-copilot",
			opts = {
				max_completions = 3,
				max_attempts = 4,
			},
		},
	},
	opts = {
		keymap = {
			preset = "none",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
			kind_icons = {
				Copilot = "",
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",
				Field = "󰜢",
				Variable = "󰆦",
				Property = "󰖷",
				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",
				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",
				Keyword = "󰻾",
				Constant = "󰏿",
				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},

		completion = {
			list = {
				selection = {
					preselect = false, -- 👈 disable auto focus
					auto_insert = false, -- extra safety: don’t auto insert
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
					max_width = 100,
					max_height = 40,
					winblend = 0,
				},
			},
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
					},
				},
			},
			-- Show ghost text preview
			ghost_text = { enabled = false },
		},

		-- Signature help (experimental)
		signature = {
			enabled = true,
			window = {
				border = "rounded",
			},
		},

		-- Sources configuration
		sources = {
			default = { "copilot", "lsp", "path", "snippets", "buffer" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 200,
					async = true,
				},
			},
		},

		-- Snippets configuration using LuaSnip
		snippets = { preset = "luasnip" },

		-- Cmdline completion
		cmdline = {
			enabled = true,
			keymap = {
				preset = "cmdline",
			},
		},

		-- Fuzzy matching - use lua implementation to avoid binary issues
		fuzzy = {
			implementation = "lua",
		},
	},
	opts_extend = { "sources.default" },
}
