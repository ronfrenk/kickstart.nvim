return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gdh', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iff [H]ead changes' },
    { '<leader>gdl', '<cmd>DiffviewOpen HEAD~1<cr>', desc = '[G]it [D]iff [L]ast commit diff' },
    { '<leader>gdm', '<cmd>DiffviewOpen main<cr>', desc = '[G]it [D]iff [m]ain' },
    { '<leader>gdc', '<cmd>DiffviewClose<cr>', desc = '[G]it [D]iff [C]lose' },
  },
}
