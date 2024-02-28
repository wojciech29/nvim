return {
    {
        'nvim-telescope/telescope.nvim',

        priority = 100,
        branch = '0.1.x',

        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
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
            require 'core.plugins.telescope.setup'
            require 'core.plugins.telescope.keys'
        end,
    },
}
