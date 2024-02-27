local builtin = require('telescope.builtin')
local file_browser = require('telescope').extensions.file_browser.file_browser
local live_grep_args = require('telescope').extensions.live_grep_args.live_grep_args
local live_grep_args_shortcuts = require('telescope-live-grep-args.shortcuts')

-- Default search
vim.keymap.set(
    'n',
    '<leader><leader>',
    builtin.find_files
)

-- File browser
vim.keymap.set(
    'n',
    '<leader>ff',
    function()
        file_browser({ path = '%:p:h' })
    end
)

-- LSP find references
vim.keymap.set(
    'n',
    '<leader>fr',
    builtin.lsp_references
)

-- Grep
vim.keymap.set(
    'n',
    '<leader>fg',
    function()
        live_grep_args()
    end
)
vim.keymap.set(
    'n',
    '<leader>fw',
    live_grep_args_shortcuts.grep_word_under_cursor
)

-- Diagnostics
vim.keymap.set(
    'n',
    '<leader>dd',
    builtin.diagnostics
)
