-- Neovim の入口。共通設定とプラグイン構成は lua/config 以下に分離する。
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("config.lazy")
