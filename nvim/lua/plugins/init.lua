-- Bootstrap
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	print("packer_bootstrap: 'packer.nvim' does not exist. Attempts to install from git repositories.")
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	api.command("packadd packer.nvim")
	print("packer_bootstrap: 'packer.nvim' is installed. Please close and reopen Neovim.")
end

-- Define packer commands
local function run_packer(method, opts)
	local packer = require("plugins.packer")
	return function()
		packer[method](opts)
	end
end

api.add_user_command("PackerInstall", run_packer("install"), { desc = "[Packer] Install plugins" })
api.add_user_command("PackerUpdate", run_packer("update"), { desc = "[Packer] Update plugins" })
api.add_user_command("PackerClean", run_packer("clean"), { desc = "[Packer] Clean plugins" })
api.add_user_command("PackerSync", function()
	vim.notify("packer.nvim: Remove unused plugins and install added plugins. Exists will be updated to the latest.")
	run_packer("sync")()
end, {
	desc = "[Packer] Sync plugins",
})
api.add_user_command("PackerCompile", function()
	vim.notify("packer.nvim: Compile started")
	run_packer("compile")()
end, {
	desc = "[Packer] Compile plugins",
})

if PACKER_BOOTSTRAP then
	api.command("PackerSync")
end
