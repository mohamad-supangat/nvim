local add = MiniDeps.add
local now_if_args = Config.now_if_args

vim.g.vue_pre_processors = "detect_on_enter"
vim.g.context_enabled = 1

--   vim.g.doge_filetype_aliases = {
-- "javascript"= {'vue'}
-- }
vim.doge_mapping = "<Leader>nf"

add("sheerun/vim-polyglot")
-- add("wellle/context.vim")
--
now_if_args(function()
	add("https://github.com/romus204/tree-sitter-manager.nvim")
	add("https://github.com/Darazaki/indent-o-matic")

	add("alvan/vim-closetag") -- vim verson auto close tag
	-- add("windwp/nvim-ts-autotag") -- treesitter version auto close tag
	-- add("nvim-treesitter/nvim-treesitter-context")
	add("JoosepAlviste/nvim-ts-context-commentstring")
	add("danymat/neogen")

	local languages = {
		"lua",
		"markdown_inline",
		"vimdoc",
		"lua",
		"typescript",
		"vue",
		"pug",
		"python",
		-- "php",
		-- "phpdoc",
		"prisma",
		"markdown",
		"html",
		"blade",
		"vim",
		"json",
		"css",
		"dockerfile",
		"bash",
		"fish",
		"javascript",
		"scss",
		"http",
		"xml",
		"yaml",
	}
	require("tree-sitter-manager").setup({
		ensure_installed = languages,
	})

	require("indent-o-matic").setup({
		max_lines = 2048,
		standard_widths = { 2, 4, 8 },
		skip_multiline = true,
	})

	-- require("ts_context_commentstring").setup({
	-- 	enable_autocmd = false,
	-- 	languages = {
	-- 		blade = "{{-- %s --}}",
	-- 	},
	-- })

	-- require("ts-comments").setup({
	--   lang = {
	--     blade = "{{-- %s --}}",
	--   },
	-- })

	-- require("treesitter-context").setup({
	-- 	enable = true, -- enable this plugin (can be enabled/disabled later via commands)
	-- 	max_lines = 0, -- how many lines the window should span. values <= 0 mean no limit.
	-- 	min_window_height = 0, -- minimum editor window height to enable context. values <= 0 mean no limit.
	-- 	line_numbers = true,
	-- 	multiline_threshold = 20, -- maximum number of lines to show for a single context
	-- 	trim_scope = "outer", -- which context lines to discard if `max_lines` is exceeded. choices: 'inner', 'outer'
	-- 	mode = "cursor", -- line used to calculate context. choices: 'cursor', 'topline'
	-- 	separator = "_",
	-- 	zindex = 20, -- the z-index of the context window
	-- })

	-- require("nvim-ts-autotag").setup({
	-- 	opts = {
	-- 		enable_close = true,
	-- 		enable_rename = true,
	-- 		enable_close_on_slash = false,
	-- 	},
	-- 	aliases = {
	-- 		["blade"] = "html",
	-- 		["html.handlebars"] = "html",
	-- 	},
	-- })

	require("neogen").setup({})

	-- Neogen keymap
	vim.keymap.set("n", "<Leader>nf", function()
		require("neogen").generate()
	end, { noremap = true, silent = true, desc = "Generate documentation" })
end)
