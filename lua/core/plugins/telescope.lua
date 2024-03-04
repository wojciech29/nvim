return {
{
    'nvim-telescope/telescope.nvim',

    priority = 100,
    branch = '0.1.x',

    dependencies = {
        'nvim-lua/plenary.nvim',
        "nvim-telescope/telescope-frecency.nvim",
        'nvim-telescope/telescope-live-grep-args.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        {
            'nvim-telescope/telescope-smart-history.nvim',
            dependencies = {
                'kkharji/sqlite.lua',
            }
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
    },
    config = function()
        local actions = require 'telescope.actions'
        local builtin = require 'telescope.builtin'
        local file_browser = require('telescope').extensions.file_browser.file_browser
        local live_grep_args = require('telescope').extensions.live_grep_args.live_grep_args
        local small_layout = {
            horizontal = {
                prompt_position = 'top',
            },
            width = 0.55,
            height = 0.45,
        }

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
                sorting_strategy = 'ascending',
                layout_config = {
                    horizontal = {
                        prompt_position = 'top',
                        preview_width = 0.5,
                        results_width = 0.5,
                    },
                    -- https://github.com/nvim-telescope/telescope.nvim/issues/2508#issuecomment-1650278179
                    width = { padding = 0 },
                    height = { padding = 0 },
                    preview_cutoff = 120,
                },
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
                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                        ['<C-R>'] = actions.cycle_history_prev,
                        ['<C-T>'] = actions.cycle_history_next,
                    },
                },
                history = {
                    path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
                    limit = 100,
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    no_ignore = true,
                    previewer = false,
                    layout_config = small_layout,
                },
            },
            extensions = {
                file_browser = {
                    collapse_dirs = true,
                    grouped = true,
                    respect_gitignore = false,
                    hijack_netrw = true,     -- disables netrw and use telescope-file-browser in its place
                },
                fzf = {
                    fuzzy = true,                       -- false will only do exact matching
                    override_generic_sorter = true,     -- override the generic sorter
                    override_file_sorter = true,        -- override the file sorter
                    case_mode = "smart_case",           -- or "ignore_case" or "respect_case"
                },
                frecency = {
                    previewer = false,
                    show_filter_column = false,
                    layout_config = small_layout,
                }
            }
        }

        pcall(require('telescope').load_extension, 'smart_history')
        pcall(require('telescope').load_extension, 'file_browser')
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'live_grep_args')
        pcall(require('telescope').load_extension, 'frecency')

        -- Default search
        vim.keymap.set(
            'n',
            '<leader>sf',
                "<Cmd>Telescope frecency workspace=CWD<CR>"
            )
            vim.keymap.set(
                'n',
                '<leader><leader>',
                builtin.find_files
            )

            -- File browser
            vim.keymap.set(
                'n',
                '<leader>sb',
                function()
                    file_browser({ path = '%:p:h' })
                end
            )

            -- LSP find references
            vim.keymap.set(
                'n',
                '<leader>gr',
                builtin.lsp_references
            )

            -- Grep
            vim.keymap.set(
                'n',
                '<leader>sg',
                function()
                    live_grep_args()
                end
            )
            vim.keymap.set(
                'n',
                '<leader>sw',
                require('telescope-live-grep-args.shortcuts').grep_word_under_cursor
            )

            -- Diagnostics
            vim.keymap.set(
                'n',
                '<leader>sd',
                builtin.diagnostics
            )

            -- Help Tags
            vim.keymap.set(
                'n',
                '<leader>sh',
                builtin.help_tags
            )
        end,
    },
}
