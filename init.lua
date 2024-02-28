require('core.options')
require('core.keymaps')
require('core.plugins-setup')

-- vim.cmd.colorscheme 'kanagawa'
vim.cmd.colorscheme 'duskfox'
local TelescopeColor = {
    TelescopeMatching = { fg = '#f6c177' },
}

for hl, col in pairs(TelescopeColor) do
    vim.api.nvim_set_hl(0, hl, col)
end

local DefaultGroup = vim.api.nvim_create_augroup('DefaultGroup', {})
local autocmd = vim.api.nvim_create_autocmd

-- remove trailing whitespace on save
autocmd({ "BufWritePre" }, {
    group = DefaultGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = DefaultGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})
