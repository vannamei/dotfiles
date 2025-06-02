return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" },
  },
  config = function() 
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- VSCode と同じ
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = {
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "luasnip"  },
        { name = "path"     },
        { name = "buffer"   },
      },
    })
  end,
}
