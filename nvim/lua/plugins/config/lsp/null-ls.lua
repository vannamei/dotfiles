local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
	return
end

local common_opts = require("plugins.config.lsp.settings.common")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	sources = {
		formatting.stylua,
		formatting.prettier.with({
			condition = function(utils)
				return utils.has_file({ ".prettierrc", ".prettier.js" })
			end,
			extra_args = {
				"--no-semi",
				"--single-quote",
				"--jsx-single-quote",
			},
		}),
		formatting.black.with({
			extra_args = { "--fast" },
		}),
		formatting.rustfmt,
		diagnostics.flake8,
		diagnostics.markdownlint,
	},
	default_timeout = 10000,
	on_attach = common_opts.on_attach,
	capabilities = common_opts.capabilities,
})
