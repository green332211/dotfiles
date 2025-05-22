require "nvchad.options"

-- add yours here!
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- add yours here!

local o = vim.o
o.foldmethod = "expr"
vim.opt.foldlevel = 99
o.foldexpr = "nvim_treesitter#foldexpr()"
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
