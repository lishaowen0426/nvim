local on_attach = function(client, bufnr)
	local bufopts = {noremap=true, silent=true, buffer=bufnr}
	vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition,  bufopts)
	vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references,  bufopts)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
    vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
    vim.keymap.set("n", "<leader>1gD", vim.lsp.buf.type_definition, keymap_opts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, keymap_opts)
    vim.keymap.set("n", "<leader>g0", vim.lsp.buf.document_symbol, keymap_opts)
    vim.keymap.set("n", "<leader>gW", vim.lsp.buf.workspace_symbol, keymap_opts)
    vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, keymap_opts)

    -- Show diagnostic popup on cursor hover
    local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
      end,
      group = diag_float_grp,
    })

    -- Goto previous/next diagnostic warning/error
    vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, keymap_opts)
    vim.keymap.set("n", "g]", vim.diagnostic.goto_next, keymap_opts)
end

local lsp_flags = {
	debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

--local servers = { 'clangd', }
--for _, lsp in ipairs(servers) do
require('lspconfig').clangd.setup {
on_attach = on_attach,
capabilities = capabilities,
cmd = {"clangd", '--query-driver=/usr/local/bin/gcc,/usr/local/bin/g++'},
}
--end
require('lspconfig').pyright.setup {
on_attach = on_attach,
capabilities = capabilities,
}


local rust_opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  server = {
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
        diagnostics = { enable = true,
                    disabled = {"inactive-code"}
        },
      },
    },
  },
}

require("rust-tools").setup(rust_opts)
