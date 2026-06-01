return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    open_mapping = [[<c-\>]],
    terminal_mappings = true,
    start_in_insert = true,
    shell = "zsh",
    winbar = {
      enabled = true,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end
    },
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true }),
  },
}
