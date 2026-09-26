-- LazyVim の既定値に対する個人設定。
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus" -- macOS のコピー・ペーストと共有する。
vim.opt.undofile = true           -- 閉じた後も undo 履歴を保存する。
vim.opt.swapfile = true           -- 異常終了時に未保存データを復旧できるようにする。
vim.opt.mouse = "a"
vim.opt.winblend = 0
vim.opt.pumblend = 0
vim.g.snacks_animate = false      -- アニメーションを省き操作感を軽くする。
vim.g.autoformat = false          -- 整形は Space c f。保存時に勝手に書き換えない。
-- 新構成は Lua 製プラグイン中心のため、外部言語ホストの自動探索を省く。
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
