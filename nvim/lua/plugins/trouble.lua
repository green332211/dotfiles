return {
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {}
    end,
  },
}
