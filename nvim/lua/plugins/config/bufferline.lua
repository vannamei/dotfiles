local ok, bufferline = pcall(require, "bufferline")
if not ok then
	return
end

local c = {
	fujiWhite = "#DCD7BA",
	oldWhite = "#C8C093",
	sumiInk0 = "#16161D",
	sumiInk1 = "#1F1F28",
	sumiInk2 = "#2A2A37",
	sumiInk3 = "#363646",
	sumiInk4 = "#54546D",
	waveBlue1 = "#223249",
	carpYellow = "#E6C384",
	autumunGreen = "#76946A",
}

bufferline.setup({
	options = {
		mode = "buffers",
		numbers = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		indicator = {
			style = "icon",
		},
		buffer_close_icon = "",
		modified_icon = "❢",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		--- name_formatter can be used to change the buffer's label in the bufferline.
		--- Please note some names can/will break the
		--- bufferline so use this at your discretion knowing that it has
		--- some limitations that will *NOT* be fixed.
		-- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
		--   -- remove extension from markdown files for example
		--   if buf.name:match('%.md') then
		--     return vim.fn.fnamemodify(buf.name, ':t:r')
		--   end
		-- end,
		max_name_length = 30,
		max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
		tab_size = 21,
		diagnostics = false, -- | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
		--   return "("..count..")"
		-- end,
		-- NOTE: this will be called a lot so don't do any heavy processing here
		-- custom_filter = function(buf_number)
		--   -- filter out filetypes you don't want to see
		--   if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
		--     return true
		--   end
		--   -- filter out by buffer name
		--   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
		--     return true
		--   end
		--   -- filter out based on arbitrary rules
		--   -- e.g. filter out vim wiki buffer from tabline in your work repo
		--   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
		--     return true
		--   end
		-- end,
		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = true,
		always_show_bufferline = true,
		-- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
		--   -- add custom logic
		--   return buffer_a.modified > buffer_b.modified
		-- end
	},
	highlights = {
		fill = {
			fg = c.sumiInk2,
			bg = c.sumiInk2,
		},
		background = {
			fg = c.fujiWhite,
			bg = c.sumiInk1,
		},
		numbers = {
			fg = c.fujiWhite,
			bg = c.sumiInk1,
		},
		numbers_selected = {
			fg = c.carpYellow,
			bg = c.waveBlue1,
			bold = true,
			italic = true,
		},
		numbers_visible = {
			fg = c.fujiWhite,
		},
		buffer = {
			fg = c.fujiWhite,
			bg = c.sumiInk1,
		},
		buffer_selected = {
			fg = c.carpYellow,
			bg = c.waveBlue1,
			bold = true,
			italic = true,
		},
		buffer_visible = {
			fg = c.fujiWhite,
		},
		close_button = {
			fg = c.fujiWhite,
			bg = c.sumiInk1,
		},
		close_button_selected = {
			fg = c.fujiWhite,
			bg = c.waveBlue1,
		},
		close_button_visible = {
			fg = c.fujiWhite,
		},
		diagnostic = {},
		diagnostic_visible = {},
		diagnostic_selected = {
			bold = true,
			italic = true,
		},
		hint = {},
		hint_visible = {},
		hint_selected = {
			bold = true,
			italic = true,
		},
		hint_diagnostic = {},
		hint_diagnostic_visible = {},
		hint_diagnostic_selected = {
			bold = true,
			italic = true,
		},
		info = {},
		info_visible = {},
		info_selected = {
			bold = true,
			italic = true,
		},
		info_diagnostic = {},
		info_diagnostic_visible = {},
		info_diagnostic_selected = {
			bold = true,
			italic = true,
		},
		warning = {},
		warning_visible = {},
		warning_selected = {
			bold = true,
			italic = true,
		},
		warning_diagnostic = {},
		warning_diagnostic_visible = {},
		warning_diagnostic_selected = {
			bold = true,
			italic = true,
		},
		error = {},
		error_visible = {},
		error_selected = {
			bold = true,
			italic = true,
		},
		error_diagnostic = {},
		error_diagnostic_visible = {},
		error_diagnostic_selected = {
			bold = true,
			italic = true,
		},
		modified = {
			fg = c.carpYellow,
			bg = c.sumiInk1,
		},
		modified_selected = {
			fg = c.carpYellow,
			bg = c.waveBlue1,
		},
		modified_visible = {
			fg = c.carpYellow,
		},
		duplicate_selected = {
			italic = true,
		},
		duplicate_visible = {
			italic = true,
		},
		duplicate = {
			italic = true,
		},
		separator = {
			fg = c.oldWhite,
			bg = c.sumiInk1,
		},
		indicator_selected = {
			fg = c.fujiWhite,
			bg = c.waveBlue1,
		},
		pick_selected = {
			bold = true,
			italic = true,
		},
		pick_visible = {
			bold = true,
			italic = true,
		},
		pick = {
			bold = true,
			italic = true,
		},
		offset_separator = {},
	},
})
