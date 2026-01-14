vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
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
    vim.api.nvim_win_set_width(netrw_win, 25)

    -- Return focus to the file window
    vim.api.nvim_set_current_win(file_win)

    vim.api.nvim_echo({
      { '🦇 Welcome, Master Wayne 🦇', 'SpecialComment' },
    }, true, {})
  end,
})
