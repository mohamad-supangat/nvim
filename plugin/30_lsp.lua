local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now
local now_if_args = Config.now_if_args
local config = require("config_reader").read_config()

if config.lsp.native then
	now(function()
		add("mason-org/mason.nvim")
		add("https://github.com/neovim/nvim-lspconfig")
		add("https://github.com/mason-org/mason-lspconfig.nvim")

		local capabilities = require("lsp.capabilities")
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_enable = true,
		})

		-- vim.lsp.enable({
		-- 	"tombi",
		-- 	"vtsls",
		-- 	"vue_ls",
		-- 	"ts_ls",
		-- 	"tsgo",
		-- 	"lua_ls",
		-- 	"emmylua_ls",
		-- 	"kulala_ls",
		-- 	"phpantom_lsp",
		-- 	"intelephense",
		-- 	"emmet_language_server",
		-- 	"tailwindcss",
		-- 	"marksman",
		-- 	"pyright",
		-- 	"ty",
		-- 	"mpls",
		-- })
	end)

	if config.format.conform then
		later(function()
			add("stevearc/conform.nvim")

			local util = require("conform.util")
			require("conform").setup({
				formatters_by_ft = {
					["*"] = { "trim_whitespace", "trim_newlines" },
					dart = { "dart_format" },
					lua = { "stylua" },
					python = { "blue", "ruff_fix", "ruff_format" },
					php = { "php_cs_fixer", "lsp" },
					blade = { "blade-formatter" },
					javascript = { "prettier" },
					markdown = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					jsonc = { "prettier" },
					json5 = { "prettier" },
					vue = { "prettier" },
					pug = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					sass = { "prettier" },
					bash = { "shfmt" },
					fish = { "fish_indent" },
					sh = { "shfmt" },
					nginx = { "nginxfmt" },
					http = { "kulala" },
					sql = { "sqruff" },
					jinja = { "djlint" },
				},

				formatters = {
					kulala = {
						command = "kulala-fmt",
						args = { "format", "$FILENAME" },
						stdin = false,
					},
					php_cs_fixer = {
						command = "php-cs-fixer",
						env = {
							PHP_CS_FIXER_IGNORE_ENV = "1",
						},
						args = { "fix", "$FILENAME" },
						stdin = false,
						cwd = util.root_file({ ".rootdir", "composer.json" }),
					},
				},
			})

			vim.api.nvim_create_user_command("Format", function()
				-- vim.lsp.buf.format({ async = false, timeout_ms = 1000, })
				require("conform").format({ lsp_fallback = true, async = false })
			end, {
				desc = "Format using lsp then conform",
			})

			vim.keymap.set("n", "<Leader>fm", "<Cmd>Format<CR>", { noremap = true, silent = true, desc = "Format" })
			vim.keymap.set(
				"n",
				"<Leader>fM",
				"<Cmd>lua vim.lsp.buf.format({ async = false, timeout_ms = 1000, })<CR>",
				{ noremap = true, silent = true, desc = "Format" }
			)

			vim.keymap.set(
				"x",
				"<Leader>fm",
				"<Cmd>Format<CR>",
				{ noremap = true, silent = true, desc = "Format selection" }
			)

			vim.keymap.set(
				"x",
				"<Leader>fM",
				"<Cmd>lua vim.lsp.buf.format({ async = false, timeout_ms = 1000, })<CR>",
				{ noremap = true, silent = true, desc = "Format" }
			)
		end)
	end

	now_if_args(function()
		add("https://github.com/nvim-flutter/flutter-tools.nvim")
		require("flutter-tools").setup({})
	end)
end
