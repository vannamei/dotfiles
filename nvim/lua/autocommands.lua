local DisableIME = api.create_augroup("DisableIME", { clear = true })
-- Linux
if vim.loop.os_uname().sysname == "Linux" then
	api.create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
		group = DisableIME,
		command = "silent! :call system('fcitx-remote -c')",
	})
end
-- WSL2
if os.execute("uname -a | grep microsoft") ~= "" then
	api.create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
		group = DisableIME,
		command = "silent! :call system('${WIN_ZENHAN} 0')",
	})
end

local BgTransparent = api.create_augroup("BgTransparent", { clear = true })
api.create_autocmd("Colorscheme", {
	group = BgTransparent,
	command = "highlight Normal ctermbg=none guibg=none",
})
api.create_autocmd("Colorscheme", {
	group = BgTransparent,
	command = "highlight NonText ctermbg=none guibg=none",
})
api.create_autocmd("Colorscheme", {
	group = BgTransparent,
	command = "highlight LineNr ctermbg=none guibg=none",
})
api.create_autocmd("Colorscheme", {
	group = BgTransparent,
	command = "highlight Folded ctermbg=none guibg=none",
})
api.create_autocmd("Colorscheme", {
	group = BgTransparent,
	command = "highlight EndOfBuffer ctermbg=none guibg=none",
})

local PackerCompile = api.create_augroup("PackerCompile", { clear = true })
api.create_autocmd("BufWritePost", {
	group = PackerCompile,
	pattern = "packer.lua",
	command = "source <afile> | PackerCompile",
	once = false,
})
