return {
  cmd = { "intelephense", "--stdio" },
  root_markers = { ".rootdir", "composer.json", ".git" },
  filetypes = { "php", "blade" },
  settings = {
    intelephense = {
      telemetry = {
        enabled = false
      }
    }
  }

}
