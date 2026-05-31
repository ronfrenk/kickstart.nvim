-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      filtered_items = {
        visible = true, -- When true, it allows you to see "hidden" items
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          -- ".DS_Store",
          -- "thumbs.db",
        },
        never_show = { -- remains hidden even if visible is toggled to true
          -- ".DS_Store",
          -- "thumbs.db",
        },
      },
    },
  },
}
