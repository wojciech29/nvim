local TelescopeColor = {
    TelescopeMatching = { fg = '#f6c177' },
}

for hl, col in pairs(TelescopeColor) do
    vim.api.nvim_set_hl(0, hl, col)
end
