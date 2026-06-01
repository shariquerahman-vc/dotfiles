vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.swapfile = false

-- Load Leader Key --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Filetype detection --
vim.filetype.add({
  filename = {
    ["Jenkinsfile"] = "groovy",
  },
  pattern = {
    ["[Jj]enkinsfile.*"] = "groovy",
    [".*%.jenkinsfile"] = "groovy",
    [".*%.gradle"] = "groovy",
  },
})

-- Load Lazy --
require("config.lazy")
