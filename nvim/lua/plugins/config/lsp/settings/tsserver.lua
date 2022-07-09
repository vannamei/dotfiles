local root_pattern = require("lspconfig").util.root_pattern
local node_root_pattern = root_pattern("package.json", "tsconfig.json")

return {
	root_dir = node_root_pattern,
}
