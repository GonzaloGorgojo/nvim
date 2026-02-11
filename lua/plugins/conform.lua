return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>fb",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
			{
				"<leader>cf",
				function()
					if vim.b.disable_autoformat then
						vim.cmd("FormatEnable")
						vim.notify("Enabled autoformat for current buffer")
					else
						vim.cmd("FormatDisable!")
						vim.notify("Disabled autoformat for current buffer")
					end
				end,
				desc = "Toggle autoformat for current buffer",
			},
			{
				"<leader>cF",
				function()
					if vim.g.disable_autoformat then
						vim.cmd("FormatEnable")
						vim.notify("Enabled autoformat globally")
					else
						vim.cmd("FormatDisable")
						vim.notify("Disabled autoformat globally")
					end
				end,
				desc = "Toggle autoformat globally",
			},
			{
				"<leader>fs",
				function()
					local start = vim.api.nvim_buf_get_mark(0, "<")
					local finish = vim.api.nvim_buf_get_mark(0, ">")

					require("conform").format({
						range = {
							start = { start[1], start[2] },
							["end"] = { finish[1], finish[2] },
						},
						lsp_format = "fallback",
					})
				end,
				mode = "v",
				desc = "Format selected lines",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				html = { "prettierd", "prettier" },
				yaml = { "prettierd", "prettier" },
				yml = { "prettierd", "prettier" },
				handlebars = { "djlint" },
				hcl = { "packer_fmt" },
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },

				-- JavaScript / TypeScript / React
				javascript = { "eslint_d", "prettierd", "prettier" },
				typescript = { "eslint_d", "prettierd", "prettier" },
				javascriptreact = { "eslint_d", "prettierd", "prettier" },
				typescriptreact = { "eslint_d", "prettierd", "prettier" },

				json = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				scss = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },

				go = { "gofmt" },
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- :FormatDisable! disables autoformat for this buffer only
					vim.b.disable_autoformat = true
				else
					-- :FormatDisable disables autoformat globally
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true, -- allows the ! variant
			})

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})
		end,
	},
}
