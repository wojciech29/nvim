vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use 'nvim-treesitter/nvim-treesitter-context'
    use {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup({
                filetypes = { "html" , "xml", "eruby", "embedded_template", "htmldjango" }
            })
        end
    }

    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use { "ntk148v/habamax.nvim", requires={ "rktjmp/lush.nvim" } }

    use { "ellisonleao/gruvbox.nvim" }
    use "folke/tokyonight.nvim"
    use 'navarasu/onedark.nvim'
    use 'aktersnurra/no-clown-fiesta.nvim'
    use 'shaunsingh/nord.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }

    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- use 'lukas-reineke/indent-blankline.nvim'

    use 'EdenEast/nightfox.nvim'

    use({
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' }
    })
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope-file-browser.nvim' }
    use 'fannheyward/telescope-coc.nvim'

    use {'neoclide/coc.nvim', branch = 'release'}

    use({
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup()
        end,
    })

    -- use {
    --     'VonHeikemen/lsp-zero.nvim',
    --     branch = 'v3.x',
    --     requires = {
    --         --- Uncomment these if you want to manage LSP servers from neovim
    --         {'williamboman/mason.nvim'},
    --         {'williamboman/mason-lspconfig.nvim'},

    --         -- LSP Support
    --         {'neovim/nvim-lspconfig'},
    --         -- Autocompletion
    --         {'hrsh7th/cmp-nvim-lsp'},
    --         {'hrsh7th/nvim-cmp'},
    --         {'L3MON4D3/LuaSnip'}
    --     }
    -- }
end)
