local actions = require 'telescope.actions'
local action_layout = require 'telescope.actions.layout'
local previewers = require 'telescope.previewers'
local sorters = require 'telescope.sorters'

require('telescope').setup {
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
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        scroll_strategy = 'cycle',
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                prompt_position = 'top',
                preview_width = 0.5,
                results_width = 0.5,
            },
            -- https://github.com/nvim-telescope/telescope.nvim/issues/2508#issuecomment-1650278179
            width={padding=0},
            height={padding=0},
            preview_cutoff = 120,
        },
        file_sorter = sorters.get_fuzzy_file,
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
            'lazy-lock',
        },
        generic_sorter = sorters.get_generic_fuzzy_sorter,
        path_display = { 'truncate' },
        winblend = 0,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        color_devicons = false,
        disable_devicons = true,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = previewers.buffer_previewer_maker,
        mappings = {
            n = {
                ['q'] = actions.close
            },
            i = {
                ['<C-R>'] = actions.cycle_history_prev,
                ['<C-T>'] = actions.cycle_history_next,
                ['<C-g>s'] = actions.select_all,
                ['<C-g>a'] = actions.add_selection,
                ['<M-p>'] = action_layout.toggle_preview,
                ['<C-w>'] = function()
                    vim.api.nvim_input '<c-s-w>'
                end,
            },
        },
        history = {
            path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
            limit = 100,
        },
    },
    pickers = {
        find_files = {
            find_command = vim.fn.executable 'fdfind' == 1 and { 'fdfind', '--strip-cwd-prefix', '--type', 'f' } or nil,
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
            case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case'
        },
    }
}
