local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add('CRAG666/code_runner.nvim')
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
      php = "php",
      javascript = "node",
      rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
    },
  })
end)
