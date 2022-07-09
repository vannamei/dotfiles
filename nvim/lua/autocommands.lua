local DisableIME = vim.api.nvim_create_augroup("DisableIME", { clear = true })
if OSTYPE == "WSL" then
	vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
		group = DisableIME,
		command = "silent! :call system('${ZENHAN} 0')",
	})
elseif OSTYPE == "Linux" then
	vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
		group = DisableIME,
		command = "silent! :call system('fcitx-remote -c')",
	})
end

local BgTransparent = vim.api.nvim_create_augroup("BgTransparent", { clear = true })
vim.api.nvim_create_autocmd("Colorscheme", {
	group = BgTransparent,
	command = "highlight Normal ctermbg=none guibg=none",
})
vim.api.nvim_create_autocmd("Colorscheme", {
	group = BgTransparent,
	command = "highlight NonText ctermbg=none guibg=none",
})
vim.api.nvim_create_autocmd("Colorscheme", {
	group = BgTransparent,
	command = "highlight LineNr ctermbg=none guibg=none",
})
vim.api.nvim_create_autocmd("Colorscheme", {
	group = BgTransparent,
	command = "highlight Folded ctermbg=none guibg=none",
})
vim.api.nvim_create_autocmd("Colorscheme", {
	group = BgTransparent,
	command = "highlight EndOfBuffer ctermbg=none guibg=none",
})

local PackerCompile = vim.api.nvim_create_augroup("PackerCompile", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = PackerCompile,
	pattern = "packer.lua",
	command = "source <afile> | PackerCompile",
	once = false,
})
