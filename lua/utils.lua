local M = {}

function M.get_root(cwd)
  local status, job = pcall(require, "plenary.job")
  if not status then
    return fn.system("git rev-parse --show-toplevel")
  end

  local gitroot_job = job:new({
    "git",
    "rev-parse",
    "--show-toplevel",
    cwd = cwd,
  })

  local path, code = gitroot_job:sync()
  if code ~= 0 then
    return nil
  end

  return table.concat(path, "")
end

function M.currentFileRootPath()
  local current_dir = vim.fn.expand("%:p:h")
  local git_root = M.get_root(current_dir)
  return git_root
end

function M.GitAutoCommit(message)
  -- Helper function to perform common git operations
  local function perform_git_operations(commit_msg)
    vim.cmd("Git add .")
    vim.cmd(string.format("Git commit -m %s", commit_msg:gsub(" ", "\\ ")))
    vim.cmd("Git push")

    vim.notify("Git auto commit dan push selesai.", vim.log.levels.INFO, { title = "Git Auto Commit" })
  end

  if message == nil or message == "" then
    -- If no message is provided, prompt the user asynchronously using vim.ui.input
    vim.ui.input({
      prompt = "Masukkan pesan commit (kosong untuk pesan default): ",
      -- Optional: 'completion' can be 'file', 'dir', or 'shell'
      -- completion = "file",
    }, function(user_input)
      local commit_message_final
      -- Check if user provided input (not nil for cancel, not empty string for blank input)
      if user_input ~= nil and user_input ~= "" then
        vim.notify_once(user_input, vim.log.levels.INFO, { title = "Pesan Commit yang dikirimkan" })
        -- Use user's input if provided
        commit_message_final = user_input
        perform_git_operations(commit_message_final)
      else
        -- Generate default message if user input is empty or cancelled
        local current_datetime = os.date("%Y-%m-%d %H:%M:%S")
        commit_message_final = "auto commit from neovim: " .. current_datetime
      end
      -- Perform git operations with the determined message
    end)
  else
    -- If a message is provided, proceed directly with git operations
    perform_git_operations(message)
  end
end

function M.is_huawei_host()
  local hostname_file = "/etc/hostname"
  local f = io.open(hostname_file, "r")

  if not f then
    -- Gagal membuka file, anggap bukan 'huawei'
    -- Ini bisa terjadi jika file tidak ada atau ada masalah izin.
    return false
  end

  local hostname = f:read("*l") -- Baca baris pertama
  f:close()

  if not hostname then
    return false -- Gagal membaca konten
  end

  -- Hapus whitespace (terutama newline) dari akhir string
  hostname = hostname:gsub("%s+", "")

  return hostname == "huawei"
end

return M
