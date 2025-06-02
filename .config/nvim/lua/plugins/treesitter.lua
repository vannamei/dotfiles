return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,

  opts = {
    ensure_installed = "all",
    highlight = { enable = true },
    indent = { enable = true },
  },
}
