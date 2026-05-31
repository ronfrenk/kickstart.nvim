vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    openNeoTree()
    batSignal()
    vim.api.nvim_echo({
      { '🦇 Welcome, Master Wayne 🦇', 'SpecialComment' },
    }, true, {})
  end,
})

function openEx()
  -- Only when a file is opened
  if vim.fn.argc() == 0 then
    return
  end

  -- Only if netrw isn't already visible
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), 'filetype') == 'netrw' then
      return
    end
  end

  -- Save the current file window
  local file_win = vim.api.nvim_get_current_win()

  -- Open left split for netrw
  vim.cmd 'topleft vsplit'
  vim.cmd 'Ex'

  -- Force the left window to 25 columns
  local netrw_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_width(netrw_win, 35)

  -- Return focus to the file window
  vim.api.nvim_set_current_win(file_win)
end

local neo_tree_width = 35
function openNeoTree()
  local git_files = {
    'COMMIT_EDITMSG',
    'MERGE_MSG',
    'SQUASH_MSG',
    'TAG_EDITMSG',
    'git-rebase-todo',
    '.',
  }
  local filename = vim.fn.fnamemodify(vim.fn.argv(0), ':t')
  -- Only run if a file is opened
  if vim.fn.argc() == 0 or vim.tbl_contains(git_files, filename) then
    return
  end

  -- Check if Neo-Tree is already open
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == 'neo-tree' then
      return
    end
  end

  -- 1. Grab initial state
  local file_win = vim.api.nvim_get_current_win()
  local file_buf = vim.api.nvim_get_current_buf()
  local is_dir = vim.fn.argv(0) == '.'

  -- 2. Open Neo-tree
  -- 'last' ensures it doesn't just replace the current buffer if it's a directory
  vim.cmd 'Neotree show left'
  local neo_win = vim.api.nvim_get_current_win()

  -- 3. Resize
  vim.api.nvim_win_set_width(neo_win, neo_tree_width)

  -- Standard file open: focus the file
  vim.api.nvim_set_current_win(file_win)
  -- Ensure the buffer is correct
  vim.api.nvim_win_set_buf(file_win, file_buf)
end

function batSignal()
  -- Define the Batman ASCII art and message
  local batman_art = [[
                    ,.ood888888888888boo.,
               .od888P^""            ""^Y888bo.
           .od8P''   ..oood88888888booo.    ``Y8bo.
        .odP'"  .ood8888888888888888888888boo.  "`Ybo.
      .d8'   od8'd888888888f`8888't888888888b`8bo   `Yb.
     d8'  od8^   8888888888[  `'  ]8888888888   ^8bo  `8b
   .8P  d88'     8888888888P      Y8888888888     `88b  Y8.
  d8' .d8'       `Y88888888'      `88888888P'       `8b. `8b
 .8P .88P            """"            """"            Y88. Y8.
 88  888                                              888  88
 88  888                                              888  88
 88  888.        ..                        ..        .888  88
 `8b `88b,     d8888b.od8bo.      .od8bo.d8888b     ,d88' d8'
  Y8. `Y88.    8888888888888b    d8888888888888    .88P' .8P
   `8b  Y88b.  `88888888888888  88888888888888'  .d88P  d8'
     Y8.  ^Y88bod8888888888888..8888888888888bod88P^  .8P
      `Y8.   ^Y888888888888888LS888888888888888P^   .8P'
        `^Yb.,  `^^Y8888888888888888888888P^^'  ,.dP^'
           `^Y8b..   ``^^^Y88888888P^^^'    ..d8P^'
               `^Y888bo.,            ,.od888P^'
                    "`^^Y888888888888P^^'"         

                At your service, Master Wayne 🦇
]]

  -- Create the keybinding
  -- Using <leader>batman as the trigger
  vim.keymap.set('n', '<leader>bat', function()
    vim.notify(batman_art, vim.log.levels.INFO, {
      title = 'Wayne Manor',
    })
  end, { desc = "Summon the Dark Knight's butler" })
end
