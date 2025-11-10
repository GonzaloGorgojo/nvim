return {
	-- Main LSP + Completion Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- LSP installer & tooling
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- LSP status UI
		{ "j-hui/fidget.nvim", opts = {} },

		-- Completion plugins
		"hrsh7th/nvim-cmp", -- main completion plugin
		"hrsh7th/cmp-nvim-lsp", -- LSP source
		"hrsh7th/cmp-buffer", -- buffer words
		"hrsh7th/cmp-path", -- filesystem paths
		"hrsh7th/cmp-cmdline", -- command-line completions
		"hrsh7th/cmp-nvim-lua", -- lua completions

		-- Snippets
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp-signature-help", -- signature help
	},
	config = function()
		-- ==========================================
		-- Completion Setup
		-- ==========================================
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.config.setup({})

		cmp.setup({
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			completion = { completeopt = "menu,menuone,noinsert,noselect" },
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "nvim_lsp_signature_help" },
			},
		})

		-- ==========================================
		-- LSP Setup
		-- ==========================================
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local servers = {
			html = {},
			cssls = {},
			tailwindcss = {},
			gopls = {},
			eslint = {},
			prismals = {},
			bashls = {},
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				},
			},
		}

		-- Install tools automatically
		local ensure_installed = vim.tbl_keys(servers)
		vim.list_extend(ensure_installed, {
			"stylua",
			"prettierd",
			"prettier",
			"eslint_d",
			"shellcheck",
			"shfmt",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = false,
			automatic_enable = true,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities =
						vim.tbl_deep_extend("force", {}, capabilities, require("cmp_nvim_lsp").default_capabilities())
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		-- ==========================================
		-- Keymaps & Autocommands
		-- ==========================================
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local function map(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				-- LSP navigation
				vim.keymap.set("n", "gr", function()
					require("telescope.builtin").lsp_references({ previewer = true, show_line = false })
				end, { desc = "[G]oto [R]eferences" })
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- LSP actions
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				-- Highlight references
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method("textDocument/documentHighlight", event.buf) then
					-- Use buffer-specific group name to avoid conflicts
					local highlight_group = vim.api.nvim_create_augroup("lsp-highlight-" .. event.buf, { clear = true })

					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.clear_references,
					})
				end

				-- Inlay hints toggle
				if client and client.supports_method("textDocument/inlayHint", event.buf) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- ==========================================
		-- Diagnostic Config
		-- ==========================================
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			virtual_text = { source = "if_many", spacing = 2 },
			signs = {
				{ name = "DiagnosticSignError", text = "󰅚" },
				{ name = "DiagnosticSignWarn", text = "󰀪" },
				{ name = "DiagnosticSignInfo", text = "󰋽" },
				{ name = "DiagnosticSignHint", text = "󰌶" },
			},
		})
	end,
}
