local opts = { noremap = true, silent = true }

-- Use space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

------------
-- Normal --
------------
-- Navigate windows
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
-- Resize window with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", opts)
-- Delete search highlight
vim.keymap.set("n", "<esc><esc>", ":nohlsearch<cr>", opts)
-- Packer(Plugin manager)
vim.keymap.set("n", "<leader>ps", ":PackerSync<cr>", opts)
vim.keymap.set("n", "<leader>pc", ":PackerCompile<cr>", opts)
-- Finder
vim.keymap.set("n", "<leader>tf", ":Telescope find_files<cr>", opts)
vim.keymap.set("n", "<leader>tg", ":Telescope live_grep<cr>", opts)
vim.keymap.set("n", "<leader>tb", ":Telescope buffers<cr>", opts)
vim.keymap.set("n", "<leader>th", ":Telescope help_tags<cr>", opts)
-- Filer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
-- Buffer
vim.keymap.set("n", "<c-n>", ":BufferLineCycleNext<cr>", opts) -- bufferline
vim.keymap.set("n", "<c-p>", ":BufferLineCyclePrev<cr>", opts) -- bufferline
vim.keymap.set("n", "<c-q>", ":Bdelete<cr>", opts) -- bbye
-- Translate
vim.keymap.set("n", "<leader>y", ":Translate<cr>", opts) -- en => ja
vim.keymap.set("n", "<leader>Y", ":Translate!<cr>", opts) -- ja => en
-- ToggleTerminal
vim.keymap.set("n", "<leader>\\", ":ToggleTerm<cr>", opts)

------------
-- Insert --
------------
-- Fast escape
vim.keymap.set("i", "jk", "<esc>", opts)
vim.keymap.set("i", "ｊｋ", "<esc>", opts)

------------
-- Visual --
------------
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
-- Translate
vim.keymap.set("v", "<leader>y", ":'<,'>Translate<cr>", opts) -- en => ja
vim.keymap.set("v", "<leader>Y", ":'<,'>Translate!<cr>", opts) -- ja => en

------------------
-- Visual Block --
------------------
-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<cr>gv-gv", opts)
vim.keymap.set("x", "K", ":move '<-2<cr>gv-gv", opts)
vim.keymap.set("x", "<A-j>", ":move '>+1<cr>gv-gv", opts)
vim.keymap.set("x", "<A-k>", ":move '<-2<cr>gv-gv", opts)

--------------
-- Terminal --
--------------
-- Navigate terminal
-- vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
