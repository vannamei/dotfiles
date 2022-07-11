local dashboard_ok, dashboard = pcall(require, "dashboard")
if not dashboard_ok then
	return
end

local home = os.getenv("HOME")

vim.g.dashboard_default_executive = "telescope"

dashboard.custom_header = {
	[[                                                        ]],
	[[                   *   ,MMM8&&&.            *           ]],
	[[                      MMMM88&&&&&    .                  ]],
	[[                     MMMM88&&&&&&&                      ]],
	[[   *                 MMM88&&&&&&&&                      ]],
	[[                     MMM88&&&&&&&&                      ]],
	[[                     'MMM88&&&&&&'                      ]],
	[[                       'MMM8&&&'      *                 ]],
	[[             |\___/|                                    ]],
	[[             )     (             .              '       ]],
	[[            =\     /=                                   ]],
	[[              )===(       *                             ]],
	[[             /     \                                    ]],
	[[             |     |                                    ]],
	[[            /       \                                   ]],
	[[            \       /                                   ]],
	[[      _/\_/\_/\__  _/_/\_/\_/\_/\_/\_/\_/\_/\_/\_       ]],
	[[      |  |  |  |( (  |  |  |  |  |  |  |  |  |  |       ]],
	[[      |  |  |  | ) ) |  |  |  |  |  |  |  |  |  |       ]],
	[[      |  |  |  |(_(  |  |  |  |  |  |  |  |  |  |       ]],
	[[      |  |  |  |  |  |  |  |  |  |  |  |  |  |  |       ]],
	[[      |  |  |  |  |  |  |  |  |  |  |  |  |  |  |       ]],
	[[]],
}

dashboard.custom_center = {
	{
		icon = "  ",
		desc = "Recently latest session                 ",
		action = "SessionLoad",
		shortcut = "SPC s l",
	},
	{
		icon = "  ",
		desc = "Recently opened files                   ",
		action = "Telescope oldfiles",
		shortcut = "SPC f h",
	},
	{
		icon = "  ",
		desc = "Find File                               ",
		action = "Telescope find_files find_command=rg,--hidden,--files",
		shortcut = "SPC f f",
	},
	{
		icon = "  ",
		desc = "File Browser                            ",
		action = "Telescope file_browser",
		shortcut = "SPC f b",
	},
	{
		icon = "  ",
		desc = "Find word                               ",
		action = "Telescope live_grep",
		shortcut = "SPC f w",
	},
	-- {
	-- 	icon = "  ",
	-- 	desc = "Open Personal dotfiles                  ",
	-- 	action = "lua require('telescope.buildin').dotfiles() path=" .. home .. "/.dotfiles",
	-- 	shortcut = "SPC f d",
	-- },
}
dashboard.custom_footer = "github.com/vannamei"

dashboard.hide_tabline = false
dashboard.hide_statusline = false
