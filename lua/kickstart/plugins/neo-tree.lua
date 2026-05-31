-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  config = function(_, opts)
    -- 1. Run the standard setup
    require('neo-tree').setup(opts)

    local git_files = {
      'COMMIT_EDITMSG',
      'MERGE_MSG',
      'SQUASH_MSG',
      'TAG_EDITMSG',
      'git-rebase-todo',
    }

    -- Get the filename and check for Git or empty arguments
    local arg0 = vim.fn.argv(0)
    local filename = vim.fn.fnamemodify(arg0, ':t')

    -- GUARD: Don't do anything if no args or if we are in a Git flow
    if vim.fn.argc() == 0 or vim.tbl_contains(git_files, filename) then
      return
    end

    -- 2. Handle Directory Focus (nvim .)
    if vim.fn.isdirectory(arg0) == 1 then
      vim.schedule(function()
        vim.cmd 'Neotree reveal'

        -- Search for the tree window and focus it
        local wins = vim.api.nvim_list_wins()
        for _, win in ipairs(wins) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == 'neo-tree' then
            vim.api.nvim_set_current_win(win)
            break
          end
        end
      end)
    end
  end,
  opts = {
    filesystem = {
      hijack_netrw_behavior = 'open_default',
      filtered_items = {
        visible = true, -- This makes hidden files visible by default
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          -- ".DS_Store",
          -- "thumbs.db"
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
