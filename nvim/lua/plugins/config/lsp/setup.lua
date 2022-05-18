local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_ok then
	return
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("plugins.config.lsp.default_opts").on_attach,
		capabilities = require("plugins.config.lsp.default_opts").capabilities,
		handlers = require("plugins.config.lsp.default_opts").handlers,
	}

	local has_server_opts, server_opts = pcall(require, "plugins.config.lsp.settings." .. server.name)
	if has_server_opts then
		opts = vim.tbl_deep_extend("force", server_opts, opts)
	end

	server:setup(opts)
end)
