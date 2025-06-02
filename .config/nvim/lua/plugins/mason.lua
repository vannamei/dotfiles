return {
  "mason-org/mason.nvim",
  dependencies = {
    { "mason-org/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = false,
      ensure_installed = { "ts_ls", "pyright", "lua_ls" },
    })
  end,
}
