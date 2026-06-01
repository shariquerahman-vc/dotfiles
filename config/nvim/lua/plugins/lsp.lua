return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      capabilities.textDocument = capabilities.textDocument or {}
      capabilities.textDocument.semanticTokens = vim.tbl_deep_extend(
        "force",
        capabilities.textDocument.semanticTokens or {},
        {
          multilineTokenSupport = true,
        }
      )

      vim.lsp.config("*", { capabilities = capabilities })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "vimls",
          "lua_ls",
          "bashls",
          "clangd",
          "cssls",
          "dockerls",
          "docker_compose_language_service",
          "gopls",
          "groovyls",
          "helm_ls",
          "html",
          "jsonls",
          "pyright",
          "terraformls",
          "ts_ls",
          "yamlls",
        },
        automatic_enable = true,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          local clients = vim.lsp.get_clients({ bufnr = args.buf, method = "textDocument/formatting" })
          if #clients > 0 then
            vim.lsp.buf.format({ async = false, bufnr = args.buf })
          end
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
    end,
  },
}
