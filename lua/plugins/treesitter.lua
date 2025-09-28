return {
    -- Treesitter for syntax highlighting, indentation, and text objects
    {
	'nvim-treesitter/nvim-treesitter',
	build = ":TSUpdate",
	config = function()
	    local configs = require("nvim-treesitter.configs")
	    configs.setup({
		highlight = { enable = true },   -- code highlighting
		indent = { enable = true },      -- smart indentation
		autotag = { enable = true },     -- auto-closing HTML/JSX tags
		ensure_installed = {
		    "lua",
		    "go",
		    "javascript",
		    "typescript",
		    "tsx",
		    "json",
		    "html",
		    "css",
		    "bash",
		    "c",
		    "diff",
		    "luadoc",
		    "markdown",
		    "markdown_inline",
		    "query",
		    "vim",
		    "vimdoc",
		},
		auto_install = true,             -- automatically install missing parsers
	    })
	end
    },

    -- Sticky context: shows current function/class at the top of the window
    {
	'nvim-treesitter/nvim-treesitter-context',
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	config = function()
	    require('treesitter-context').setup{
		enable = true,               -- enable plugin
		max_lines = 5,               -- max number of lines to show at top
		min_window_height = 0,       -- show even in small windows
		trim_scope = 'outer',        -- show outer scope
		patterns = {
		    default = { 'class', 'function', 'method' }, -- fallback for any language
		    lua = { 'function', 'local_function' },
		    go = { 'func', 'method_declaration' },
		    javascript = { 'function', 'method', 'class' },
		    typescript = { 'function', 'method', 'class' },
		    tsx = { 'function', 'method', 'class' },
		},
	    }
	end
    },
}
