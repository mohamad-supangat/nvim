local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add("olimorris/codecompanion.nvim")
  add("ravitemer/codecompanion-history.nvim")


  local Spinner = {
    processing = false,
    spinner_index = 1,
    namespace_id = nil,
    timer = nil,
    spinner_symbols = {
      "⠋",
      "⠙",
      "⠹",
      "⠸",
      "⠼",
      "⠴",
      "⠦",
      "⠧",
      "⠇",
      "⠏",
    },
    filetype = "codecompanion",
  }

  function Spinner:get_buf(filetype)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == filetype then
        return buf
      end
    end
    return nil
  end

  function Spinner:update_spinner()
    if not self.processing then
      self:stop_spinner()
      return
    end

    self.spinner_index = (self.spinner_index % #self.spinner_symbols) + 1

    local buf = self:get_buf(self.filetype)
    if buf == nil then
      return
    end

    -- Clear previous virtual text
    vim.api.nvim_buf_clear_namespace(buf, self.namespace_id, 0, -1)

    local last_line = vim.api.nvim_buf_line_count(buf) - 1
    vim.api.nvim_buf_set_extmark(buf, self.namespace_id, last_line, 0, {
      virt_lines = { { { self.spinner_symbols[self.spinner_index] .. " Processing...", "Comment" } } },
      virt_lines_above = true, -- false means below the line
    })
  end

  function Spinner:start_spinner()
    self.processing = true
    self.spinner_index = 0

    if self.timer then
      self.timer:stop()
      self.timer:close()
      self.timer = nil
    end

    self.timer = vim.loop.new_timer()
    self.timer:start(
      0,
      100,
      vim.schedule_wrap(function()
        self:update_spinner()
      end)
    )
  end

  function Spinner:stop_spinner()
    self.processing = false

    if self.timer then
      self.timer:stop()
      self.timer:close()
      self.timer = nil
    end

    local buf = self:get_buf(self.filetype)
    if buf == nil then
      return
    end

    vim.api.nvim_buf_clear_namespace(buf, self.namespace_id, 0, -1)
  end

  function Spinner:init()
    -- Create namespace for virtual text
    self.namespace_id = vim.api.nvim_create_namespace("CodeCompanionSpinner")

    vim.api.nvim_create_augroup("CodeCompanionHooks", { clear = true })
    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionRequest*",
      group = group,
      callback = function(request)
        if request.match == "CodeCompanionRequestStarted" then
          self:start_spinner()
        elseif request.match == "CodeCompanionRequestFinished" then
          self:stop_spinner()
        end
      end,
    })
  end

  require(
    'codecompanion'
  ).setup({
    extensions = {
      history = {
        enabled = true, -- defaults to true
        opts = {
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
        }
      }
    },
    interactions = {
      chat = {
        adapter = {
          name = 'gemini',
          model = 'gemini-3-flash-preview',
        },
        opts = {
          completion_provider = 'blink',
        },
        keymaps = {
        },
      },
      inline = {
        adapter = {
          name = 'gemini',
          model = 'gemini-3-flash-preview',
        },
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "gr" },
            description = "Reject the suggested change",
          },
        },
      },
    },
    opts = {
      language = "Indonesia",
    },
    display = {
      chat = {
        start_in_insert_mode = false,
        show_references = true,
        separator = "─",
        window = {
          layout = "float",
          height = 0.9,
          width = 0.9,
          opts = {
            breakindent = true,
            cursorcolumn = false,
            cursorline = false,
            foldcolumn = "0",
            linebreak = true,
            list = true,
            number = false,
            -- signcolumn = "yes",
            spell = false,
            wrap = true,
          },
        },
      },
    },
  })


  Spinner:init()
end)
