local utils = require("utils")
local merge_functions = utils.merge_functions

return {
	-- variable
	no_formatting = function(client)
		client.resolved_capabilities.document_formatting = false
	end,

	-- function
	merge_opts = function(server_opts)
		local common_opts = require("plugins.config.lsp.settings.common")
		local merged_opts = vim.tbl_deep_extend("force", server_opts, common_opts)
		merged_opts.on_attach = merge_functions(server_opts.on_attach, common_opts.on_attach)
		return merged_opts
	end,
}
