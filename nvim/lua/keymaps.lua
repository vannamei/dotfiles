local opts = { noremap = true, silent = true }

-- Use space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Startup(Dashboard)
vim.keymap.set("n", "<leader>ss", ":<c-u>SessionSave<cr>")
vim.keymap.set("n", "<leader>sl", ":<c-u>SessionLoad<cr>")
vim.keymap.set("n", "<leader>fh", ":DashboardFindHistory<cr>", opts)
vim.keymap.set("n", "<leader>ff", ":DashboardFindFile<cr>", opts)
vim.keymap.set("n", "<leader>tc", ":DashboardChangeColorscheme<cr>", opts)
vim.keymap.set("n", "<leader>fa", ":DashboardFindWord<cr>", opts)
vim.keymap.set("n", "<leader>fb", ":DashboardJumpMark<cr>", opts)
vim.keymap.set("n", "<leader>cn", ":DashboardNewFile<cr>", opts)

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
-- Telescope(Fuzzy finder)
vim.keymap.set("n", "<leader>tb", ":Telescope buffers<cr>", opts)
vim.keymap.set("n", "<leader>th", ":Telescope help_tags<cr>", opts)
-- NvimTree(File exploler)
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
-- Motion
vim.keymap.set(
	"n",
	"f",
	":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
	opts
)
vim.keymap.set(
	"n",
	"F",
	":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
	opts
)
vim.keymap.set(
	"o",
	"f",
	":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
	opts
)
vim.keymap.set(
	"o",
	"F",
	":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
	opts
)
vim.keymap.set(
	"",
	"t",
	":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
	opts
)
vim.keymap.set(
	"",
	"T",
	":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
	opts
)
-- Trouble
vim.keymap.set("n", "<leader>xx", ":Trouble<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", ":Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", ":Trouble document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", ":Trouble loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", ":Trouble quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", ":Trouble lsp_references<cr>", { silent = true, noremap = true })
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
