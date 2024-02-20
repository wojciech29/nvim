require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '-L',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
        },
        prompt_prefix = '   ',
        selection_caret = '  ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                prompt_position = 'top',
                preview_width = 0.45,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.92,
            height = 0.92,
            preview_cutoff = 120,
        },
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        file_ignore_patterns = {
            'node_modules',
            '__pycache__',
            '^backend/build/',
            '^backend/sphinxsearch/',
            '.idea',
            '.git/',
            '.ruff_cache',
            '.mypy_cache',
            '.gradle',
            '%.java',
            '%.jpg',
            '%.jpeg',
            '%.png',
            '%.jar',
            '%.gz',
            '%.bz2',
            '%.zip',
            '%.exe',
            '%.pdf',
            'ktlint',
        },
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        path_display = { 'truncate' },
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
        mappings = {
            n = { ['q'] = require('telescope.actions').close },
            i = {
                ["<C-R>"] = require('telescope.actions').cycle_history_prev,
                ["<C-T>"] = require('telescope.actions').cycle_history_next,
            },
        },
    },
    pickers = {
        buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
        },
        find_files = {
            hidden = true,
            no_ignore = true,
        }
    },
    extensions = {
        file_browser = {
            collapse_dirs = true,
            grouped = true,
            respect_gitignore = false,
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
        },
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
        }
    }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
require('telescope').load_extension('file_browser')

local builtin = require('telescope.builtin')
local file_browser = require('telescope').extensions.file_browser.file_browser
local coc = require('telescope').extensions.coc.coc

vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
vim.keymap.set('n', '<leader>ff', function() file_browser({ path = '%:p:h' }) end, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fr', ':Telescope coc references<CR>', {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})

local colors = require('nightfox.palette').load("duskfox")
local TelescopeColor = {
	TelescopeMatching = { fg = colors.yellow.base },
}

for hl, col in pairs(TelescopeColor) do
	vim.api.nvim_set_hl(0, hl, col)
end
