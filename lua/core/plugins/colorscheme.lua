return {
    {
        'EdenEast/nightfox.nvim',
    },
    {
        'rebelot/kanagawa.nvim',
        config = function()
            require('kanagawa').setup({
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none"
                            }
                        }
                    }
                }
            })
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                on_highlights = function(hl, c)
                    hl.TelescopeBorder = {
                        bg = c.bg_dark,
                        fg = c.fg_gutter,
                    }
                    hl.TelescopePromptTitle = {
                        bg = c.bg_dark,
                        fg = c.fg_gutter,
                    }
                    hl.TelescopePreviewTitle = {
                        bg = c.bg_dark,
                        fg = c.fg_gutter,
                    }
                    hl.TelescopeResultsTitle = {
                        bg = c.bg_dark,
                        fg = c.fg_gutter,
                    }
                end,
            })
        end
    },
}
