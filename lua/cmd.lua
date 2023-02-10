local api = vim.api

local mine = api.nvim_create_augroup("Mine", {clear = true})
api.nvim_create_autocmd({"VimLeave"}, {
    command = ":<CR>",
    group = mine,
})


vim.api.nvim_create_user_command('Z', 'w | qa', {desc = 'save and quit all'})


local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})


