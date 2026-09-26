-- lazy.nvim を初回のみ取得する。以後のバージョンは lazy-lock.json で記録する。
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local result = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("lazy.nvim の取得に失敗しました:\n" .. result)
  end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  spec = {
    -- メンテナンスされている統合設定を土台に、個人設定だけを追加する。
    { "LazyVim/LazyVim", version = "16.0.1", import = "lazyvim.plugins" },
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
  -- この構成に LuaRocks 依存はないため、追加の Lua 環境を作らない。
  rocks = { enabled = false },
  install = { colorscheme = { "tokyonight", "habamax" } },
  -- 更新は :Lazy update で明示的に行う。起動時の自動更新確認は省略する。
  checker = { enabled = false },
  change_detection = { notify = false },
})
