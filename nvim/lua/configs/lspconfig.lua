require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "pyright", "jsonls", "emmet_ls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

-- Добавляет границы при вызове shift+k
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
