local init = (function()
	local packer
	return function()
		if packer == nil then
			api.command("packadd packer.nvim")
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
			-- Packer
			{ "wbthomason/packer.nvim", opt = true },

			-- Dependencies
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },

			-- Colorscheme
			{
				"w0ng/vim-hybrid",
				setup = function()
					api.command("colorscheme hybrid")
				end,
				opt = true,
			},

			-- Commenting
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

			-- Finder
			{
				"nvim-telescope/telescope.nvim",
				requires = {
					{ "nvim-telescope/telescope-media-files.nvim" },
				},
				cmd = "Telescope*",
				module = "telescope",
				config = function()
					require("plugins.config.telescope")
				end,
			},

			-- Parser
			{
				"nvim-treesitter/nvim-treesitter",
				event = { "BufNewFile", "BufRead" },
				config = function()
					require("plugins.config.treesitter")
				end,
				run = ":TSUpdate",
			},

			-- Language server
			{
				"neovim/nvim-lspconfig",
				requires = {
					{ "williamboman/nvim-lsp-installer" },
					{
						"jose-elias-alvarez/null-ls.nvim",
						requires = {
							"nvim-lua/plenary.nvim",
							"nvim-lsp-installer",
						},
					},
				},
				config = function()
					require("plugins.config.lsp")
				end,
			},

			-- Completion
			{
				"hrsh7th/nvim-cmp",
				requires = {
					"L3MON4D3/LuaSnip",
					"rafamadriz/friendly-snippets",
					{ "hrsh7th/cmp-nvim-lsp", requires = {
						"neovim/nvim-lspconfig",
					} },
					{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
					{ "hrsh7th/cmp-path", after = "nvim-cmp" },
					{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
					{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
					{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
					{
						"windwp/nvim-autopairs",
						after = "nvim-cmp",
						config = function()
							require("plugins.config.autopairs")
						end,
					},
				},
				config = function()
					require("plugins.config.cmp")
				end,
			},

			-- Filer
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

			-- Buffer
			{
				"akinsho/bufferline.nvim",
				requires = {
					"kyazdani42/nvim-web-devicons",
					{ "moll/vim-bbye", after = "bufferline.nvim" },
				},
				config = function()
					require("plugins.config.bufferline")
				end,
			},

			-- Status line
			{
				"nvim-lualine/lualine.nvim",
				requires = {
					"kyazdani42/nvim-web-devicons",
				},
				config = function()
					require("plugins.config.lualine")
				end,
			},

			-- Terminal
			{
				"akinsho/toggleterm.nvim",
				cmd = "ToggleTerm",
				config = function()
					require("plugins.config.toggleterm")
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

			-- Rust
			{
				"rust-lang/rust.vim",
				ft = { "rust" },
			},

			-- Markdown
			{
				"iamcco/markdown-preview.nvim",
				cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
				ft = { "markdown" },
				setup = function()
					vim.g.mkdp_auto_close = 0
					vim.g.mkdp_echo_preview_url = 1
					vim.g.mkdp_open_to_the_world = 1
				end,
			},

			-- WordPress
			{ "dsawardekar/wordpress.vim", ft = { "php" } },

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
