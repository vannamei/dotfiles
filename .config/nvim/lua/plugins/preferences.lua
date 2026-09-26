return {
  -- 以前の Tokyo Night を継続。透過専用プラグインは増やさずテーマで指定する。
  { "folke/tokyonight.nvim", opts = { style = "night", transparent = true } },
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
  -- 補完・検索・ファイルツリー・Git表示は LazyVim の標準構成を利用する。
  -- AI 補完は必要になった時に :LazyExtras から有効にできる。
}
