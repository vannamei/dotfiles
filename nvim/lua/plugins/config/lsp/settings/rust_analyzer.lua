return {
	on_attach = require("plugins.config.lsp.utils").no_formatting,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
}
