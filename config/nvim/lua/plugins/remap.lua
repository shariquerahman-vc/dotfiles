-- lua/plugins/remap.lua
return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
    priority = 10000,
    init = function()
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- General
      keymap("n", "<leader>e", ":Oil<CR>", opts)
      keymap("n", "<leader>w", ":w<CR>", opts)
      keymap("n", "<leader>q", ":q<CR>", opts)
      keymap("n", "<leader>h", ":nohlsearch<CR>", opts)
      keymap("n", "<leader>n", ":bn<CR>", opts)
      keymap("n", "<leader>p", ":bp<CR>", opts)

      -- Window management
      keymap("n", "<leader>sv", "<C-w>v", opts)
      keymap("n", "<leader>sh", "<C-w>s", opts)
      keymap("n", "<leader>se", "<C-w>=", opts)
      keymap("n", "<leader>sx", ":close<CR>", opts)

      -- Tabs
      keymap("n", "<leader>to", ":tabnew<CR>", opts)
      keymap("n", "<leader>tx", ":tabclose<CR>", opts)
      keymap("n", "<leader>tn", ":tabn<CR>", opts)
      keymap("n", "<leader>tp", ":tabp<CR>", opts)

      -- Move lines
      keymap("n", "<A-j>", ":m .+1<CR>==", opts)
      keymap("n", "<A-k>", ":m .-2<CR>==", opts)
      keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
      keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
      keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
      keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
      keymap("n", "<C-f>", function() vim.lsp.buf.format({ async = true }) end, opts)
    end,
  }
}
