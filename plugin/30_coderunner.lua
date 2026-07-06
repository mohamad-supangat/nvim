local add, later = MiniDeps.add, MiniDeps.later
local config = require("config_reader").read_config()

if config.plugins.code_runner then
	later(function()
		add("CRAG666/code_runner.nvim")
		local code_runner = require("code_runner")
		code_runner.setup({
			mode = "float",
			focus = false,
			float = {
				border = "rounded",
			},
			-- put here the commands by filetype
			filetype = {
				fish = "fish",
				-- http = "restcli",
				java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
				python = "python3 -u",
				-- typescript = "deno run -A",
				-- typescript = "node --env-file=.env  --experimental-strip-types --experimental-transform-types",
				typescript = "bun",
				typescriptreact = "bun",
				javascriptreact = "bun",
				php = "php",
				javascript = "node",
				rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
			},
		})
	end)

	-- Code runner mappings
	vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = false, desc = "Run code" })

	vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false, desc = "Run file" })

	vim.keymap.set("n", "<leader>rft", ":RunFile tab<CR>", { noremap = true, silent = false, desc = "Run file in tab" })

	vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false, desc = "Run project" })

	vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false, desc = "Run close" })

	vim.keymap.set(
		"n",
		"<leader>crf",
		":CRFiletype<CR>",
		{ noremap = true, silent = false, desc = "Change runner filetype" }
	)

	vim.keymap.set(
		"n",
		"<leader>crp",
		":CRProjects<CR>",
		{ noremap = true, silent = false, desc = "Change runner project" }
	)
end
