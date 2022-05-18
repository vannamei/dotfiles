local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end

wk.setup({})
