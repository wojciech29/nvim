return {
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
							whitespace = "#363646",
						},
					},
				},
			},
		})
		vim.cmd.colorscheme("kanagawa")
	end,
}
