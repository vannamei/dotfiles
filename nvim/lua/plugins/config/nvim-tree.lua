local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_ok then
	return
end

nvim_tree.setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = { "l", "<CR>", "o" }, action = "edit" },
				{ key = "h", action = "close_node" },
				{ key = "v", action = "vsplit" },
				{ key = "u", action = "dir_up" },
			},
		},
	},
	renderer = {
		group_empty = true,
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
	},
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 250,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
})
