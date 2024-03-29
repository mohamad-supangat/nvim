local status_ok, code_runner = pcall(require, "code_runner")
if not status_ok then
  return
end

code_runner.setup({
  -- mode = "toggle",
  focus = false,
  -- put here the commands by filetype
  filetype = {
    fish = "fish",
    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    python = "python3 -u",
    typescript = "deno run",
    javascript = "node",
    php = "php",
    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
  },
})

vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rft", ":RunFile tab<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false })
