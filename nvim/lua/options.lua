local options = {
	autoread = true,
	backup = false,
	swapfile = false,
	undofile = true,
	writebackup = false,

	fileencoding = "utf-8",
	helplang = "ja,en",

	clipboard = "unnamedplus",
	mouse = "a",
	completeopt = { "menu", "menuone", "noselect" },

	hlsearch = true,
	showmode = false,
	showtabline = 2,

	smartcase = true,
	ignorecase = true,

	autoindent = true,
	smartindent = true,
	expandtab = true,
	shiftwidth = 4,
	tabstop = 4,

	splitbelow = true,
	splitright = true,

	timeoutlen = 1000,
	updatetime = 300,

	background = "dark",
	termguicolors = true,

	cursorline = true,

	number = true,
	relativenumber = true,
	numberwidth = 4,
	signcolumn = "yes",

	conceallevel = 0,
	pumheight = 10,

	wrap = true,
	linebreak = true,
	breakindent = true,
	showbreak = "+\\",

	cmdheight = 2,

	scrolloff = 8,
	sidescrolloff = 8,
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end
