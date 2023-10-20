require'nvim-treesitter.configs'.setup {
    dependencies = {
        'windwp/nvim-ts-autotag'
    },
    -- A list of parser names, or 'all'
    ensure_installed = {
        -- defaults
        'vim',
        'lua',
        'markdown',
        'html',
        'htmldjango',
        'css',
        'javascript',
        'typescript',
        'json',
        'sql',
        'yaml',
        'xml',
        'python',
        'kotlin',
        'rust',
        'go',
        'toml',
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        use_languagetree = true,
    },

    autotag = {
        enable = true,
        filetypes = {
          'html',
          'htmldjango',
          'javascript',
          'typescript',
          'vue',
          'css',
          'lua',
          'xml',
          'markdown',
        },
    },

    indent = {
        enable = true
    },
}
