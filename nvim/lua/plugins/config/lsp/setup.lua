local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_ok then
	return
end

local common_opts = require("plugins.config.lsp.settings.common")
local merge_opts = require("plugins.config.lsp.utils").merge_opts

lsp_installer.on_server_ready(function(server)
	local server_opts_exist, server_opts = pcall(require, "plugins.config.lsp.settings." .. server.name)
	if server_opts_exist then
		local merged_opts = merge_opts(server_opts)
		server:setup(merged_opts)
	else
		server:setup(common_opts)
	end
end)

require("plugins.config.lsp.null-ls")
