return {
    {
        'EdenEast/nightfox.nvim',
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
    },
    {
        "mcchrish/zenbones.nvim",
        dependencies = {
            "rktjmp/lush.nvim"
        },
    },
}
