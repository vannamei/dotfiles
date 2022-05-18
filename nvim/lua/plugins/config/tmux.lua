local tmux_ok, tmux = pcall(require, "tmux")
if not tmux_ok then
	return
end

tmux.setup({
	copy_sync = { enable = true },
	navigation = { enable_default_keybindings = true },
	resize = { enable_default_keybindings = true },
})
