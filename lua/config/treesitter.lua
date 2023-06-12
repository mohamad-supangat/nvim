local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

configs.setup({
  -- A list of parser names, or "all"
  ensure_installed = {"python", "vim", "lua", "vue", "javascript", "json", "typescript" },
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat,
        vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end
    -- additional_vim_regex_highlighting = true
  },
  context_commentstring = { enable = true, enable_autocmd = false },
  indent = { enable = true, disable = { "python", "php" } },
})
