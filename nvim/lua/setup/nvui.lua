
vim.opt.guifont = { "HackGenNerd Console:h11", "Meiryo UI:h11" }

local nvui_opts = {
	Frameless = 1,
	TitlebarFontSize = 12,
}
for k, v in pairs(nvui_opts) do
	local cmd = "Nvui" .. k .. " " .. v
	vim.api.nvim_command(cmd)
end

vim.keymap.set("n", "<F1>", ":NvuiToggleFullscreen", { noremap = true, silent = true })

local NvuiIMEToggle = vim.api.nvim_create_augroup("NvuiIMEToggle", {})
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	group = NvuiIMEToggle,
	command = "NvuiIMEEnable",
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	group = NvuiIMEToggle,
	command = "NvuiIMEDisable",
})
