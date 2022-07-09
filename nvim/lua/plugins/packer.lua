local init = (function()
	local packer
	return function()
		if packer == nil then
			vim.api.nvim_command("packadd packer.nvim")
			packer = require("packer")
			packer.init({
				disable_commands = true,
				display = {
					open_fn = function()
						return require("packer.util").float({ border = "rounded" })
					end,
				},
			})
		end
		packer.reset()

		-------------
		-- Plugins --
		-------------
		packer.use({
			-- Plugin Manager
			{ "wbthomason/packer.nvim", opt = true },

			-- LSP
			{
				"neovim/nvim-lspconfig",
				config = function()
					require("plugins.config.lsp")
				end,
			},
			{
				"williamboman/nvim-lsp-installer",
				requires = { { "RRethy/vim-illuminate", opt = true } },
			},
			{
				"tamago324/nlsp-settings.nvim",
				config = function()
					require("plugins.config.lsp.nlsp-settings")
				end,
			},
			{
				"tami5/lspsaga.nvim",
				config = function()
					require("plugins.config.lsp.lspsaga")
				end,
			},
			{
				"ray-x/lsp_signature.nvim",
			},
			{
				"folke/lsp-colors.nvim",
				event = "VimEnter",
			},
			{
				"folke/trouble.nvim",
				after = { "nvim-lsp-installer", "lsp-colors.nvim" },
				config = function()
					require("trouble").setup({})
				end,
			},
			{
				"jose-elias-alvarez/null-ls.nvim",
				requires = {
					"nvim-lua/plenary.nvim",
				},
			},

			-- Completion
			{
				"hrsh7th/nvim-cmp",
				requires = {
					{
						"L3MON4D3/LuaSnip",
						requires = "rafamadriz/friendly-snippets",
						event = "VimEnter",
					},
					{ "windwp/nvim-autopairs", event = "VimEnter" },
				},
				config = function()
					require("plugins.config.cmp")
				end,
			},
			{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-omni", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "hrsh7th/cmp-emoji", after = "nvim-cmp" },
			{ "hrsh7th/cmp-calc", after = "nvim-cmp" },
			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			{ "ray-x/cmp-treesitter", after = "nvim-cmp" },
			{
				"windwp/nvim-autopairs",
				event = "VimEnter",
				config = function()
					require("plugins.config.autopairs")
				end,
			},

			-- Syntax
			{
				"nvim-treesitter/nvim-treesitter",
				event = { "BufNewFile", "BufRead" },
				config = function()
					require("plugins.config.treesitter")
				end,
				run = ":TSUpdate",
			},

			-- Terminal
			{
				"akinsho/toggleterm.nvim",
				tag = "v1.*",
				cmd = "ToggleTerm",
				config = function()
					require("plugins.config.toggleterm")
				end,
			},

			-- Snippet
			{
				"L3MON4D3/LuaSnip",
				"rafamadriz/friendly-snippets",
			},

			-- Fuzzy Finder
			{
				"nvim-telescope/telescope.nvim",
				cmd = "Telescope*",
				module = "telescope",
				config = function()
					require("plugins.config.telescope")
				end,
			},

			-- Colorscheme
			{
				"rebelot/kanagawa.nvim",
				config = function()
					vim.api.nvim_command("colorscheme kanagawa")
				end,
			},

			-- Utility
			{ "rcarriga/nvim-notify", event = "VimEnter" },

			-- Icon
			{ "kyazdani42/nvim-web-devicons" },

			-- Neovim Lua Development
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "tami5/sqlite.lua", module = "sqlite" },
			{ "MunifTanjim/nui.nvim" },

			-- Tabline
			{
				"akinsho/bufferline.nvim",
				requires = { "moll/vim-bbye", after = "bufferline.nvim" },
				config = function()
					require("plugins.config.bufferline")
				end,
			},

			-- Statusline
			{
				"windwp/windline.nvim",
				config = function()
					require("plugins.config.windline")
				end,
			},

			-- Startup
			{
				"glepnir/dashboard-nvim",
				requires = {
					"nvim-telescope/telescope.nvim",
				},
				config = function()
					require("plugins.config.dashboard")
				end,
			},

			-- File explorer
			{
				"kyazdani42/nvim-tree.lua",
				requires = {
					"kyazdani42/nvim-web-devicons",
				},
				cmd = "NvimTree*",
				config = function()
					require("plugins.config.nvim-tree")
				end,
			},

			-- Git
			{
				"lewis6991/gitsigns.nvim",
				event = { "FocusLost", "CursorHold" },
				config = function()
					require("plugins.config.gitsigns")
				end,
			},

			-- Languages support
			--- Go
			{
				"ray-x/go.nvim",
				ft = { "go" },
			},
			--- Rust
			{
				"simrat39/rust-tools.nvim",
				ft = { "rust" },
				requires = { "neovim/nvim-lspconfig" },
				config = function()
					require("plugins.config.lsp.rust-tools")
				end,
			},
			--- Markdown
			{
				"davidgranstrom/nvim-markdown-preview",
				ft = { "markdown" },
			},
			-- PHP
			{
				"dsawardekar/wordpress.vim",
				ft = { "php" },
			},

			-- Comment
			{
				"numToStr/Comment.nvim",
				requires = {
					{ "nvim-treesitter/nvim-treesitter" },
					{ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
				},
				config = function()
					require("plugins.config.comment")
				end,
			},
			{ "folke/todo-comments.nvim" },

			-- Motion
			{
				"phaazon/hop.nvim",
				branch = "v1",
				config = function()
					require("hop").setup({
						keys = "etovxqpdygfblzhckisuran",
						jump_on_sole_occurrence = false,
					})
				end,
			},

			-- Search
			{ "kevinhwang91/nvim-hlslens" },

			-- Scrolling
			{ "karb94/neoscroll.nvim" },

			-- Editing support

			-- Web development
			{ "NTBBloodbath/rest.nvim" },

			-- Competitive Programming
			{ "p00f/cphelper.nvim" },
			{ "xeluxee/competitest.nvim" },

			-- Keybinding
			{
				"folke/which-key.nvim",
				config = function()
					require("plugins.config.which-key")
				end,
			},

			-- Tmux
			{
				"aserowy/tmux.nvim",
				config = function()
					require("plugins.config.tmux")
				end,
			},

			-- Remote Development
			{
				"chipsenkbeil/distant.nvim",
				config = function()
					require("plugins.config.distant")
				end,
			},

			-- Editor Config
			{ "gpanders/editorconfig.nvim" },

			-- Localize
			{ "vim-jp/vimdoc-ja" },
			{ "skanehira/translate.vim" },
		})

		return packer
	end
end)()

return setmetatable({}, {
	__index = function(_, key)
		return init()[key]
	end,
})
