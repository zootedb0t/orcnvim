return {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
}
