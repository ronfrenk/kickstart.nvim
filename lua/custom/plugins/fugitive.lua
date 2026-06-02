return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G' },
  keys = {
    { '<leader>gd', '<cmd>Gvdiffsplit HEAD~1<cr>', desc = '[G]it [D]iff last commit' },
  },
}
