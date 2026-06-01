-- lua/custom/plugins/mini.lua
return {
  {
    -- You already have this
    'nvim-mini/mini.nvim', -- (new org name; works with 'echasnovski/mini.nvim' too)
    lazy = false,
    config = function()
      -- Statusline
      require('mini.statusline').setup({ use_icons = true })
    end,
  },
}
