-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--

local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now
local now_if_args = Config.now_if_args
local config = require("config_reader").read_config()

now_if_args(function()
	add("nvim-lua/plenary.nvim")
end)

now_if_args(function()
	add("mason-org/mason.nvim")
	require("mason").setup()
end)

if config.plugins.symbol_outline then
	now_if_args(function()
		add("hedyhli/outline.nvim")
		require("outline").setup()

		-- Outline
		vim.keymap.set("n", "<F7>", "<cmd>Outline<CR>", { noremap = true, silent = true, desc = "Toggle Outline" })
	end)
end

later(function()
	add("MagicDuck/grug-far.nvim")
	vim.g.maplocalleader = ","

	require("grug-far").setup({
		transient = true,
		prefills = {
			search = "",
			flags = "--multiline",
		},
		-- engine = 'ripgrep' is default, but 'astgrep' can be specified
	})

	-- Find and replace (Spectre/grug-far)
	vim.keymap.set("n", "<leader>S", function()
		require("grug-far").open({ transient = true })
	end, { noremap = true, silent = true, desc = "Toggle Spectre" })

	vim.keymap.set({ "n", "v" }, "<leader>sw", function()
		require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
	end, { noremap = true, silent = true, desc = "Search current word" })

	vim.keymap.set("n", "<leader>sp", function()
		require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
	end, { noremap = true, silent = true, desc = "Search on current file" })

	vim.keymap.set("n", "<leader>sf", function()
		local currentFilePath = vim.api.nvim_buf_get_name(0)
		local currentFileDirectory = currentFilePath:match("(.*/)") or ""
		require("grug-far").open({ prefills = { paths = currentFileDirectory } })
	end, { noremap = true, silent = true, desc = "Toggle Spectre Current Folder" })
end)

now(function()
	add("mrjones2014/smart-splits.nvim")
	require("smart-splits").setup({})
end)
--
