return {
    {
        'nvim-telescope/telescope.nvim',

        priority = 100,
        branch = '0.1.x',

        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            },
            config = function()
                require('telescope').load_extension('file_browser')
                require('telescope').load_extension('fzf')
            end,
        },
        config = function()
            require 'core.plugins.telescope.setup'
            require 'core.plugins.telescope.keys'
        end,
    },
}
