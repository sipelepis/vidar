return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "mason-org/mason.nvim" },
    { "mason-org/mason-lspconfig.nvim" },
    -- completion (and LSP client capabilities) come from LazyVim's blink.cmp
  },
  config = function()
    local lsp = require("lsp-zero")
    lsp.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
      end, opts)
      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
      end, opts)
      vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
      end, opts)
      vim.keymap.set("n", "<leader>vd", function()
        vim.diagnostic.open_float()
      end, opts)
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
      end, opts)
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
      end, opts)
      vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
      end, opts)
      vim.keymap.set("n", "<leader>vrr", function()
        vim.lsp.buf.references()
      end, opts)
      vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
      end, opts)
      vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
      end, opts)
    end)
    vim.lsp.config("basedpyright", {
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "standard", -- or "off", "standard", "strict"
            diagnosticMode = "openFilesOnly",
            diagnosticSeverityOverrides = {
              reportAny = "none",
              reportUnknownArgumentType = "none",
              reportUnknownMemberType = "none",
              reportUnknownVariableType = "none",
              reportUnknownParameterType = "none",
              reportUnknownLambdaType = "none",
              reportMissingTypeStubs = "none",
              reportUnusedCallResult = "none",
              reportUnusedExpression = "none",
            },
          },
        },
      },
    })
    vim.lsp.config("lua_ls", lsp.nvim_lua_ls())

    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {},
    })
  end,
}
