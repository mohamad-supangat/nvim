local add = MiniDeps.add
local now_if_args = Config.now_if_args

now_if_args(function()
	add("https://github.com/SmiteshP/nvim-navic")
	add("https://github.com/b0o/incline.nvim")

	local helpers = require("incline.helpers")
	local navic = require("nvim-navic")
	require("incline").setup({
		window = {
			padding = 0,
			margin = { horizontal = 0, vertical = 0 },
		},
		render = function(props)
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
			if filename == "" then
				filename = "[No Name]"
			end
			local ft_icon = require("mini.icons").get("file", filename)
			local modified = vim.bo[props.buf].modified
			local res = {
				ft_icon and { " ", ft_icon, " " } or "",
				" ",
				{ filename, gui = modified and "bold,italic" or "bold" },
				-- guibg = "#44406e",
			}
			if props.focused then
				for _, item in ipairs(navic.get_data(props.buf) or {}) do
					table.insert(res, {
						{ " > ", group = "NavicSeparator" },
						{ item.icon, group = "NavicIcons" .. item.type },
						{ item.name, group = "NavicText" },
					})
				end
			end
			table.insert(res, " ")
			return res
		end,
	})
end)
