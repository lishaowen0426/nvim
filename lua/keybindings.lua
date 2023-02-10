local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

vim.g.diagnostics_active = true
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.hide()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
  else
    vim.g.diagnostics_active = true
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      }
    )
  end
end

vim.keymap.set('n', '<leader>tt', ':call v:lua.toggle_diagnostics()<CR>',  {noremap = true, silent = true})
vim.keymap.set('n', '<leader>fe', ':NvimTreeToggle<CR>',  {noremap = true, silent = true})
vim.keymap.set('n', '<leader>nn', ':nohl<CR>',  {noremap = true, silent = true})
vim.keymap.set('n', '<leader>ft', ':FloatermToggle<CR>',  {noremap = true, silent = true})
vim.keymap.set('n', '<leader>fk', ':FloatermKill!<CR>',  {noremap = true, silent = true})
vim.keymap.set('t', '<leader>ft', '<C-\\><C-n>:FloatermToggle<CR>',  {noremap = true, silent = true})

vim.keymap.set('n', '<leader>zz', ':Z<CR>',  {noremap = true, silent = true})
vim.keymap.set('n', '<leader>cc', ':cclose<CR>',  {noremap = true, silent = true})
vim.keymap.set('n', 'gb', ':bn<CR>',  {noremap = true, silent = true})
