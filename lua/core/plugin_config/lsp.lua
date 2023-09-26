local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup(lsp_zero.nvim_lua_ls())

local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        -- confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<C-Space>'] = cmp.mapping.confirm({select = true}),

        -- scroll up and down the documentation window
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'eslint',
        'tsserver',
        'pyright',
        'cssls',
        'kotlin_language_server',
        'rust_analyzer',
        'lua_ls',
    },
    handlers = {
        lsp_zero.default_setup,
    },
})
