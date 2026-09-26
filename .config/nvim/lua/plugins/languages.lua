return {
  -- Lua は標準構成に含まれる。既存環境で利用していた Python/JS/TS/Go を追加。
  -- サーバーは Mason の専用領域へ入れ、グローバル npm/pip 環境と分離する。
  {
    "neovim/nvim-lspconfig",
    opts = { servers = { pyright = {}, ts_ls = {}, gopls = {} } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "go", "gomod", "gosum" } },
  },
}
