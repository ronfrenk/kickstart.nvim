return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gl', '<cmd>DiffviewOpen HEAD~1<cr>', desc = '[G]it [L]ast commit diff' },
    { '<leader>gL', '<cmd>DiffviewClose<cr>', desc = '[G]it [L]ast commit diff close' },
  },
}
