-- Bootstrap
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  print("packer bootstrap: 'packer.nvim' does not exist. Attempts to install from git repositories.")
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  api.command("packadd packer.nvim")
  print("packer bootstrap: 'packer.nvim' is installed. Please close and reopen Neovim.")
end

-- Define packer commands
local function run_packer(method, opts)
  local packer = require("plugins.packer")
  return function()
    packer[method](opts)
  end
end

api.create_user_command("PackerInstall", run_packer("install"), { desc = "[Packer] Install plugins" })
api.create_user_command("PackerUpdate", run_packer("update"), { desc = "[Packer] Update plugins" })
api.create_user_command("PackerClean", run_packer("clean"), { desc = "[Packer] Clean plugins" })
api.create_user_command("PackerSync", function()
  vim.notify("packer.nvim: Syncing plugins...")
  run_packer("sync")()
end, {
  desc = "[Packer] Install added plugins, and remove unused plugins. Existing plugins will be updated to the latest.",
})
api.create_user_command("PackerCompile", function()
  vim.notify("packer.nvim: Compiling plugins...")
  run_packer("compile")()
end, {
  desc = "[Packer] Compile plugins",
})

if PACKER_BOOTSTRAP then
  api.command("PackerSync")
end
