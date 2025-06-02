return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    { "MunifTanjim/nui.nvim" },
    { "rcarriga/nvim-notify" },
  },
  config = function ()
    require("noice").setup({
      lsp = {
        progress = { enabled = true },
        signature = { enabled = true },
        hover = { enabled = true },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    })

    vim.notify = require("noice")
  end
}
