-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "kanagawa",
  transparency = true,

  -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
  -- },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "   █████████  ███████████   ██████████ ██████████ ██████   █████",
    "  ███░░░░░███░░███░░░░░███ ░░███░░░░░█░░███░░░░░█░░██████ ░░███ ",
    " ███     ░░░  ░███    ░███  ░███  █ ░  ░███  █ ░  ░███░███ ░███ ",
    "░███          ░██████████   ░██████    ░██████    ░███░░███░███ ",
    "░███    █████ ░███░░░░░███  ░███░░█    ░███░░█    ░███ ░░██████ ",
    "░░███  ░░███  ░███    ░███  ░███ ░   █ ░███ ░   █ ░███  ░░█████ ",
    " ░░█████████  █████   █████ ██████████ ██████████ █████  ░░█████",
    "  ░░░░░░░░░  ░░░░░   ░░░░░ ░░░░░░░░░░ ░░░░░░░░░░ ░░░░░    ░░░░░ ",
    "                                                                ",
    "                       Powered By  eovim                      ",
    "                                                                ",
  },
}

M.mason = {
  pkgs = {
    "lua-language-server",
    "stylua",
    "html-lsp",
    "css-lsp",
    "prettier",
    "eslint_d",
    "clangd",
    "clang-format",
    "debugpy",
    "eslint-lsp",
    "js-debug-adapter",
    "typescript-language-server",
    "emmet-ls",
    "pyright",
    "isort",
    "black",
    "pylint",
    "eslint_d",
    "marksman",
    "markdownlint-cli2",
    "mdformat",
  },
}

return M
