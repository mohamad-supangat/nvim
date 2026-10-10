-- Autocommand untuk auto-close HTML/Blade tag tanpa TreeSitter / Plugin
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'blade', 'php', 'vue', 'javascriptreact', 'typescriptreact' },
  callback = function()
    -- Map karakter '>' saat mengetik di Insert mode
    vim.keymap.set('i', '>', function()
      -- Dapatkan posisi kursor dan teks baris saat ini
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local line = vim.api.nvim_get_current_line()
      local before_cursor = line:sub(1, col)

      -- Ekstrak nama tag dari teks sebelum kursor
      local tag = before_cursor:match('<([%w%-]+)[^>]*$')

      -- Daftar self-closing tags yang tidak memerlukan tag penutup
      local void_tags = {
        area = true,
        base = true,
        br = true,
        col = true,
        embed = true,
        hr = true,
        img = true,
        input = true,
        link = true,
        meta = true,
        param = true,
        source = true,
        track = true,
        wbr = true,
      }

      -- Jika menemukan nama tag dan bukan tag self-closing
      if tag and not void_tags[tag:lower()] then
        -- Masukkan '>', buat tag penutup, lalu kembalikan kursor ke tengah
        return '>' .. '</' .. tag .. '>' .. '<Left>' .. string.rep('<Left>', #tag + 2)
      end

      return '>'
    end, { expr = true, buffer = true })
  end,
})
