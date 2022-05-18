local root_pattern = require("lspconfig").util.root_pattern
local node_root_pattern = root_pattern("package.json", "tsconfig.json")

return {
	root_dir = node_root_pattern,
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end,
}
