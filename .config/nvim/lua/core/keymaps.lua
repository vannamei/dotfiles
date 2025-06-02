local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("i", "jk", "<Esc>", { noremap = true, silent = true })

map("n", "<leader>bd", ":bd<CR>", { desc = "Close Buffer" })

-- File Tree
map("n", "<C-b>", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree" })

-- Telescope

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)


map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)

map("n", "<C-w>", ":bd<CR>", { desc = "Close Buffer" })
map("n", "<C-s>", ":w<CR>", { desc = "Save File" })
map("n", "<C-q>", ":qa!<CR>", { desc = "Quit All" })
