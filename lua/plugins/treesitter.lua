return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufRead", "BufNewFile" },
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"css",
				"go",
				"htmldjango",
				"javascript",
				"json",
				"kotlin",
				"lua",
				"markdown",
				"python",
				"rust",
				"sql",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			auto_install = true,
			ignore_install = {},
			sync_install = false,
			highlight = { enable = true },
			indent = { disable = { "python" } },
		})
	end,
}
