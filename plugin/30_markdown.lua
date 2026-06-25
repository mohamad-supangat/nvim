local add, later = MiniDeps.add, MiniDeps.later
local config = require("config_reader").read_config()

later(function()
	if config.plugins.render_markdown then
		later(function()
			add("MeanderingProgrammer/render-markdown.nvim")
			require("render-markdown").setup({
				completions = { lsp = { enabled = true } },
				heading = { position = "inline" },
				checkbox = {
					unchecked = { icon = "✘ " },
					checked = { icon = "✔ " },
					custom = { todo = { rendered = "◯ " } },
				},
			})
		end)
	end

	local obsidianPath = vim.fn.expand("~/Documents/Obsidian/")
	vim.keymap.set(
		"n",
		"<leader>nk",
		"<cmd>edit " .. obsidianPath .. "<CR>:lcd %:p:h<CR>",
		{ noremap = true, silent = true, desc = "Obsidian notes picker" }
	)

	-- add("obsidian-nvim/obsidian.nvim")
	-- require("obsidian").setup({
	-- 	legacy_commands = false,
	-- 	workspaces = {
	-- 		{
	-- 			name = "Reksa Karya",
	-- 			path = "~/Documents/Obsidian/Reksa/",
	-- 		},
	-- 		{
	-- 			name = "Aura Komputer",
	-- 			path = "~/Documents/Obsidian/AuraKomputer",
	-- 		},
	-- 	},
	-- 	notes_subdir = "notes",
	-- 	daily_notes = {
	-- 		folder = "notes/dailies",
	-- 		date_format = "%Y-%m-%d",
	-- 		alias_format = "%B %-d, %Y",
	-- 		default_tags = { "daily-notes" },
	-- 		template = nil,
	-- 	},
	-- 	templates = {
	-- 		folder = "templates",
	-- 		date_format = "%Y-%m-%d",
	-- 		time_format = "%H:%M",
	-- 	},
	-- 	frontmatter = {
	-- 		enabled = false,
	-- 	},
	-- 	checkbox = {
	-- 		enabled = true,
	-- 		create_new = true,
	-- 		order = { " ", "x", "~", "!", ">" },
	-- 	},
	-- })

	-- Obsidian keymaps
	-- vim.keymap.set("n", "<leader>no", ":Obsidian<CR>", { noremap = true, silent = true, desc = "Obsidian" })

	-- vim.keymap.set("n", "<Leader>nk", function()
	--   MiniPick.builtin.files({}, {
	--     source = {
	--       name = 'Obsidian Notes',
	--       cwd = vim.fn.expand('~/Documents/Obsidian/'),
	--     },
	--   })
	-- end, { noremap = true, silent = true, desc = "Obsidian notes picker" })
end)
