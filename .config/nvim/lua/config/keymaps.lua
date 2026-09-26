-- LazyVim 標準の Space 起点の操作を基本とする。
-- 既存の jk を維持。強制終了するショートカットは設けない。
vim.keymap.set("i", "jk", "<Esc>", { desc = "ノーマルモードに戻る" })
vim.keymap.set("n", "<leader>fs", "<cmd>write<cr>", { desc = "ファイルを保存" })
-- Command キーは端末によって届かないため、標準の Ctrl-s も利用できる。
vim.keymap.set({ "n", "i", "v" }, "<D-s>", "<Esc><cmd>write<cr>", { desc = "ファイルを保存" })
