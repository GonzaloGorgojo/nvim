return {
	-- Core DAP plugin
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- UI improvements
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",

			-- Virtual text support
			"theHamsta/nvim-dap-virtual-text",

			-- Mason integration for installing DAP adapters
			"jay-babu/mason-nvim-dap.nvim",
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},
			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run to Cursor",
			},
			{
				"<leader>dg",
				function()
					require("dap").goto_()
				end,
				desc = "Go to Line (No Execute)",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<leader>dj",
				function()
					require("dap").down()
				end,
				desc = "Down",
			},
			{
				"<leader>dk",
				function()
					require("dap").up()
				end,
				desc = "Up",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run Last",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<leader>dp",
				function()
					require("dap").pause()
				end,
				desc = "Pause",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle REPL",
			},
			{
				"<leader>ds",
				function()
					require("dap").session()
				end,
				desc = "Session",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate",
			},
			{
				"<leader>dw",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Widgets",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle DAP UI",
			},
			vim.keymap.set("n", "<leader>da", function()
				require("dapui").elements.watches.add()
			end, { desc = "Add Watch Expression" }),
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup DAP UI
			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.33 },
							{ id = "breakpoints", size = 0.33 },
							{ id = "watches", size = 0.34 },
						},
						size = 25,
						position = "left",
					},
					{
						elements = {
							-- remove "repl" to avoid that extra bottom pane
							{ id = "console", size = 1 },
						},
						size = 10,
						position = "bottom",
					},
				},
				floating = {
					border = "rounded",
					mappings = { close = { "q", "<Esc>" } },
				},
			})

			-- Setup virtual text
			require("nvim-dap-virtual-text").setup()

			-- Automatically open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			-- dap.listeners.before.event_terminated["dapui_config"] = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.event_exited["dapui_config"] = function()
			-- 	dapui.close()
			-- end

			-- Configure Node.js adapter
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			-- Helper function to read env file
			local function read_env_file(filepath)
				local env = {}
				local file = io.open(filepath, "r")
				if file then
					for line in file:lines() do
						local key, value = line:match("^([^=]+)=(.+)$")
						if key and value then
							env[key] = value
						end
					end
					file:close()
				end
				return env
			end

			dap.configurations.javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "NVIM Launch base",
					program = "${workspaceFolder}/index.js",
					cwd = "${workspaceFolder}",
					env = function()
						local env_path = vim.fn.getcwd() .. "/config/.env"
						return read_env_file(env_path)
					end,
					skipFiles = { "<node_internals>/**" },
					console = "integratedTerminal",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "NVIM Debug Integration Tests on base",
					program = "${workspaceFolder}/node_modules/.bin/mocha",
					args = {
						"--bail",
						"--exit",
						"--timeout",
						"0",
						"${workspaceFolder}/test/integration/_beforeAll.test.js",
						"${workspaceFolder}/test/integration/VELO-5013-rewards-promo-codes.js",
					},
					cwd = "${workspaceFolder}",
					env = function()
						local env_path = vim.fn.getcwd() .. "/test/.env"
						return read_env_file(env_path)
					end,
					skipFiles = { "<node_internals>/**" },
					console = "integratedTerminal",
				},
			}

			dap.configurations.typescript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "NVIM Launch backend",
					program = "${workspaceFolder}/dist/main.js",
					protocol = "inspector",
					cwd = "${workspaceFolder}/src",
					runtimeExecutable = "yarn",
					console = "integratedTerminal",
					args = { "dev" },
					env = function()
						local env_path = vim.fn.getcwd() .. "/.env"
						return read_env_file(env_path)
					end,
					skipFiles = { "<node_internals>/**" },
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "NVIM backend Seed",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "yarn",
					runtimeArgs = { "prisma:seed" },
					console = "integratedTerminal",
					env = function()
						local env_path = vim.fn.getcwd() .. "/.env"
						return read_env_file(env_path)
					end,
				},
			}
		end,
	},

	-- Optional: Mason integration to auto-install js-debug-adapter
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		cmd = { "DapInstall", "DapUninstall" },
		opts = {
			automatic_installation = true,
			ensure_installed = { "js" },
			handlers = {},
		},
	},
}
