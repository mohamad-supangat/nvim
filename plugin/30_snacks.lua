local add, now = MiniDeps.add, MiniDeps.now
local config = require("config_reader").read_config()

if config.snacks then
	now(function()
		add("https://github.com/folke/snacks.nvim")
		require("snacks").setup({
			zen = {
				toggles = {
					dim = false,
					git_signs = false,
					mini_diff_signs = false,
					-- diagnostics = false,
					-- inlay_hints = false,
				},
			},
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			dim = {
				enabled = true,
			},
			scroll = {
				enabled = false,
				animate = {
					duration = { step = 15, total = 250 },
					easing = "linear",
				},
				animate_repeat = {
					delay = 100, -- delay in ms before using the repeat animation
					duration = { step = 5, total = 50 },
					easing = "linear",
				},
				filter = function(buf)
					return vim.g.snacks_scroll ~= false
						and vim.b[buf].snacks_scroll ~= false
						and vim.bo[buf].buftype ~= "terminal"
				end,
			},
			explorer = {
				enabled = false,
			},
			scope = {},
			indent = {
				enabled = true,
				scope = {
					enabled = true,
					animate = {
						enabled = false,
					},
				},
				chunk = {
					enabled = true,
					animate = {
						enabled = false,
					},
				},
				char = "│",
				blank = " ",
			},
			picker = {
				enabled = false,
				win = {
					keys = {
						i = {
							["<M-BS>"] = "delete_word",
							["<C-BS>"] = "delete_word",
						},
					},
					actions = {
						delete_word = function()
							return "<cmd>normal! diw<cr><right>"
						end,
					},
				},
				sources = {
					explorer = {
						enabled = vim.g.explorer == "snack",
						hidden = true,
						ignored = true,
						auto_close = true,
						win = {
							list = {
								keys = {
									["l"] = { { "pick_win", "confirm" }, mode = { "n", "i" } },
								},
							},
						},
						layout = {
							layout = {
								box = "vertical",
								position = "left",
								width = 0.2,
								{
									win = "input",
									max_height = 1,
									height = 1,
									border = { "", "", "", "", "", "", "", " " },
									wo = {
										winhighlight = "FloatBorder:Normal,NormalFloat:Normal,SnacksPickerPrompt:SnacksPickerPromptTransparent",
									},
								},
								{
									win = "list",
									border = "none",
									wo = {
										winhighlight = "FloatBorder:Normal,NormalFloat:Normal",
									},
								},
							},
						},
					},
				},
			},
			input = {
				enabled = true,
				win = {
					b = {
						completion = true,
					},
					bo = {
						filetype = "snacks_input",
						buftype = "prompt",
					},
					height = 3,
					border = "rounded",
					-- https://github.com/folke/snacks.nvim/discussions/376
					keys = {
						i_del_word = { "<A-BS>", "delete_word", mode = "i", expr = true },
						i_a_cr = { "<A-CR>", "new_line", mode = { "i", "n" }, expr = true },
					},
					actions = {
						delete_word = function()
							return "<cmd>normal! diw<cr><right>"
						end,

						new_line = function()
							return "<cmd>normal! o<cr>"
						end,
					},
				},
			},
			notifier = {
				backdrop = true,
				enabled = true,
				timeout = 3000,
				top_down = false,
				style = "minimal",
			},
			quickfile = { enabled = true },
			statuscolumn = {
				left = { "mark", "sign" },
				right = { "fold", "git" },
				folds = {
					open = false, -- show open fold icons
					git_hl = false, -- use Git Signs hl for fold icons
				},
				git = {
					-- patterns to match Git signs
					patterns = { "GitSign", "MiniDiffSign" },
				},
				refresh = 50, -- refresh at most every 50ms
			},
			words = { enabled = true },
			styles = {
				notification = {
					wo = { wrap = true },
				},
				zen = {
					width = 0,
				},
			},
			lazygit = {
				configure = true,
			},
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")

				vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "Fg" })
				vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { link = "Fg" })
				vim.api.nvim_set_hl(0, "SnacksPickerDirectory", { link = "Fg" })

				vim.api.nvim_create_autocmd("User", {
					pattern = "MiniFilesActionRename",
					callback = function(event)
						Snacks.rename.on_rename_file(event.data.from, event.data.to)
					end,
				})
			end,
		})

		vim.api.nvim_create_autocmd("LspProgress", {
			---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
			callback = function(ev)
				local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
				vim.notify(vim.lsp.status(), "info", {
					id = "lsp_progress",
					title = "LSP Progress",
					opts = function(notif)
						notif.icon = ev.data.params.value.kind == "end" and " "
							or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
					end,
				})
			end,
		})

		-- Notifier
		vim.keymap.set("n", "<leader>un", function()
			Snacks.notifier.hide()
		end, { desc = "Dismiss All Notifications" })

		-- Buffer
		vim.keymap.set("n", "<leader>bd", function()
			Snacks.bufdelete()
		end, { desc = "Delete Buffer" })

		-- Git
		vim.keymap.set("n", "<leader>gi", function()
			Snacks.lazygit({ cwd = require("utils").currentFileRootPath() })
		end, { desc = "Open Lazygit" })

		vim.keymap.set("n", "<leader>gb", function()
			Snacks.git.blame_line()
		end, { desc = "Git Blame Line" })

		vim.keymap.set("n", "<leader>gB", function()
			Snacks.gitbrowse()
		end, { desc = "Git Browse" })

		vim.keymap.set("n", "<leader>gf", function()
			Snacks.lazygit.log_file()
		end, { desc = "Lazygit Current File History" })

		vim.keymap.set("n", "<leader>gl", function()
			Snacks.lazygit.log()
		end, { desc = "Lazygit Log (cwd)" })

		-- File ops
		vim.keymap.set("n", "<leader>cR", function()
			Snacks.rename.rename_file()
		end, { desc = "Rename File" })

		-- Zen mode
		vim.keymap.set("n", "<C-z>", function()
			Snacks.zen()
		end, { desc = "Toggle Zen Mode" })

		-- Lazydocker
		vim.keymap.set("n", "<leader>do", function()
			Snacks.terminal("lazydocker")
		end, { desc = "Toggle Lazydocker" })

		vim.keymap.set("n", "<leader>/", function()
			Snacks.picker.grep()
		end, { desc = "Grep" })

		vim.keymap.set("n", "<leader>:", function()
			Snacks.picker.command_history()
		end, { desc = "Command History" })

		vim.keymap.set("n", "<leader>nn", function()
			Snacks.picker.notifications()
		end, { desc = "Notification History" })

		-- Find

		vim.keymap.set("n", "<leader>fp", function()
			Snacks.picker.projects()
		end, { desc = "Projects" })

		vim.keymap.set("n", "<leader>fr", function()
			Snacks.picker.recent()
		end, { desc = "Recent" })

		-- Grep
		vim.keymap.set("n", "<leader>sb", function()
			Snacks.picker.lines()
		end, { desc = "Buffer Lines" })

		vim.keymap.set("n", "<leader>sB", function()
			Snacks.picker.grep_buffers()
		end, { desc = "Grep Open Buffers" })

		vim.keymap.set("n", "<leader>sg", function()
			Snacks.picker.grep()
		end, { desc = "Grep" })

		-- Search
		vim.keymap.set("n", '<leader>s"', function()
			Snacks.picker.registers()
		end, { desc = "Registers" })

		vim.keymap.set("n", "<leader>s/", function()
			Snacks.picker.search_history()
		end, { desc = "Search History" })

		vim.keymap.set("n", "<leader>sa", function()
			Snacks.picker.autocmds()
		end, { desc = "Autocmds" })

		vim.keymap.set("n", "<leader>sc", function()
			Snacks.picker.command_history()
		end, { desc = "Command History" })

		vim.keymap.set("n", "<leader>sC", function()
			Snacks.picker.commands()
		end, { desc = "Commands" })

		vim.keymap.set("n", "<leader>xa", function()
			Snacks.picker.diagnostics()
		end, { desc = "Diagnostics" })

		vim.keymap.set("n", "<leader>xx", function()
			Snacks.picker.diagnostics_buffer()
		end, { desc = "Buffer Diagnostics" })

		vim.keymap.set("n", "<leader>sH", function()
			Snacks.picker.highlights()
		end, { desc = "Highlights" })

		vim.keymap.set("n", "<leader>si", function()
			Snacks.picker.icons()
		end, { desc = "Icons" })

		vim.keymap.set("n", "<leader>sk", function()
			Snacks.picker.keymaps()
		end, { desc = "Keymaps" })

		vim.keymap.set("n", "<leader>sl", function()
			Snacks.picker.loclist()
		end, { desc = "Location List" })

		vim.keymap.set("n", "<leader>sq", function()
			Snacks.picker.qflist()
		end, { desc = "Quickfix List" })

		vim.keymap.set("n", "<leader>sR", function()
			Snacks.picker.resume()
		end, { desc = "Resume" })

		vim.keymap.set("n", "<leader>su", function()
			Snacks.picker.undo()
		end, { desc = "Undo History" })

		vim.keymap.set("n", "<leader>uC", function()
			Snacks.picker.colorschemes()
		end, { desc = "Colorschemes" })

		-- LSP
		vim.keymap.set("n", "gd", function()
			Snacks.picker.lsp_definitions()
		end, { desc = "Goto Definition" })

		vim.keymap.set("n", "gD", function()
			Snacks.picker.lsp_declarations()
		end, { desc = "Goto Declaration" })

		vim.keymap.set("n", "gr", function()
			Snacks.picker.lsp_references()
		end, { nowait = true, desc = "References" })

		vim.keymap.set("n", "gI", function()
			Snacks.picker.lsp_implementations()
		end, { desc = "Goto Implementation" })

		vim.keymap.set("n", "gy", function()
			Snacks.picker.lsp_type_definitions()
		end, { desc = "Goto T[y]pe Definition" })

		vim.keymap.set("n", "<leader>ss", function()
			Snacks.picker.lsp_symbols()
		end, { desc = "LSP Symbols" })

		vim.keymap.set("n", "<leader>sS", function()
			Snacks.picker.lsp_workspace_symbols()
		end, { desc = "LSP Workspace Symbols" })

		-- Misc
		vim.keymap.set("n", "<A-BS>", "<C-W>")
	end)
end
