local add, later = MiniDeps.add, MiniDeps.later

local config = require("config_reader").read_config()

later(function()
	require("mini.comment").setup({
		options = {
			custom_commentstring = function()
				if config.plugins.treesitter then
					return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
				end
				return vim.bo.commentstring
			end,
		},
	})
end)
