local function augroup(name)
  return vim.api.nvim_create_augroup('user-autocmd-' .. name, { clear = true })
end

-- Plugin manager shortcut.
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('lazy-quit'),
  pattern = 'lazy',
  callback = function()
    vim.keymap.set(
      'n',
      '<esc>',
      function() vim.api.nvim_win_close(0, false) end,
      { buffer = true, nowait = true }
    )
  end,
  desc = 'Quit lazy with <esc>',
})

-- Check if we need to reload the file when it changes outside of NeoVim.
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

-- Highlight on yank.
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight-yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if terminal window got resized.
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('auto-resize-splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Wrap and check for spelling in text filetypes.
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('txt-wrap-spell'),
  pattern = { '*.txt', '*.tex', '*.typ', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Turn off line numbers for terminal buffers.
vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup('nonumber-term'),
  callback = function()
    vim.cmd('setlocal nonumber norelativenumber')
  end,
})
