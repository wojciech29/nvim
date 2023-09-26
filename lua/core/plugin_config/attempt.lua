require('attempt').setup{
  dir = '/tmp/',
  autosave = false,
  list_buffers = false,     -- This will make them show on other pickers (like :Telescope buffers)
  initial_content = {
    py = initial_content_fn, -- Either string or function that returns the initial content
    c = initial_content_fn,
    cpp = initial_content_fn,
    java = initial_content_fn,
    rs = initial_content_fn,
    go = initial_content_fn,
    sh = initial_content_fn
  },
  ext_options = { '', 'py', 'sql', 'js' },  -- Options to choose from
  format_opts = { [''] = '[None]' },                    -- How they'll look
  run = {
    py = { 'w !python' },      -- Either table of strings or lua functions
    js = { 'w !node' },
    ts = { 'w !deno run -' },
    lua = { 'w' , 'luafile %' },
    sh = { 'w !bash' },
    pl = { 'w !perl' },
  }
}

local attempt = require('attempt')

vim.keymap.set('n', '<leader>an', attempt.new_select)        -- new attempt, selecting extension
vim.keymap.set('n', '<leader>ar', attempt.run)               -- run attempt
vim.keymap.set('n', '<leader>ad', attempt.delete_buf)        -- delete attempt from current buffer
