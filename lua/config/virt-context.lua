local status_ok, configs = pcall(require, "virt-context")
if not status_ok then return end

configs.setup({
  enable = true,   -- set it to false to disable
  position = "eol" -- top is not yet possible
})
