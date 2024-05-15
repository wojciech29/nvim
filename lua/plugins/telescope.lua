return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-frecency.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
	},
	config = function()
		local actions = require("telescope.actions")
		local lga_actions = require("telescope-live-grep-args.actions")
		local small_layout = {
			sorting_strategy = "ascending",
			layout_strategy = "center",
			borderchars = {
				prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
				results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
			},
			prompt_title = false,
			results_title = false,
			preview_title = false,
			previewer = false,
			winblend = 5,
			layout_config = {
				horizontal = {
					prompt_position = "top",
				},
				width = 0.55,
				height = 0.45,
			},
		}

		require("telescope").setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				sorting_strategy = "ascending",
				prompt_title = false,
				results_title = false,
				preview_title = false,
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.5,
						results_width = 0.5,
						-- https://github.com/nvim-telescope/telescope.nvim/issues/2508#issuecomment-1650278179
						width = { padding = 0 },
						height = { padding = 0 },
						preview_cutoff = 120,
					},
				},
				file_ignore_patterns = {
					"node_modules",
					"__pycache__",
					".env/",
					"^backend/build/",
					"^backend/sphinxsearch/",
					".idea",
					".git/",
					".ruff_cache",
					".mypy_cache",
					".gradle",
					"%.java",
					"%.jpg",
					"%.jpeg",
					"%.png",
					"%.jar",
					"%.gz",
					"%.bz2",
					"%.zip",
					"%.exe",
					"%.pdf",
					"ktlint",
					"lazy-lock",
				},
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<C-r>"] = actions.cycle_history_prev,
						["<C-S-r>"] = actions.cycle_history_next,
					},
				},
			},
			pickers = {
				diagnostics = {
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					preview_cutoff = 20,
					layout_config = {
						vertical = {
							width = {
								padding = 0.0,
							},
							height = {
								padding = 0.0,
							},
							prompt_position = "top",
							mirror = true,
						},
					},
					line_width = 100,
					prompt_title = false,
					results_title = false,
					preview_title = false,
				},
				find_files = vim.tbl_deep_extend("error", {
					hidden = true,
					no_ignore = true,
				}, small_layout),
				current_buffer_fuzzy_find = small_layout,
				lsp_references = {
					show_line = false,
				},
			},
			extensions = {
				file_browser = {
					grouped = true,
					respect_gitignore = false,
					hijack_netrw = true, -- disables netrw and use telescope-file-browser in its place
					prompt_path = true,
					prompt_title = false,
					results_title = false,
					preview_title = false,
				},
				frecency = vim.tbl_deep_extend("error", {
					show_filter_column = false,
					show_scores = false,
					max_timestamps = 50,
				}, small_layout),
				live_grep_args = {
					auto_quoting = true, -- enable/disable auto-quoting
					mappings = {
						i = {
							["<C-k>"] = lga_actions.quote_prompt(),
							["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
						},
					},
				},
			},
		})

		pcall(require("telescope").load_extension, "file_browser")
		pcall(require("telescope").load_extension, "live_grep_args")
		pcall(require("telescope").load_extension, "frecency")

		local builtin = require("telescope.builtin")
		local file_browser = require("telescope").extensions.file_browser.file_browser
		-- local live_grep_args = require("telescope").extensions.live_grep_args.live_grep_args
		local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = desc })
		end
		map("<leader>ff", "<Cmd>Telescope frecency workspace=CWD<CR>", "[F]ind using [F]recency")
		map("<leader>fh", builtin.help_tags, "[F]ind [H]elp")
		map("<leader>fw", live_grep_args_shortcuts.grep_word_under_cursor, "[F]ind current [W]ord")
		map("<leader>fg", "<Cmd>Telescope live_grep_args<CR>", "[F]ind using [G]rep")
		-- map("<leader>fg", function() live_grep_args() end, "[F]ind using [G]rep")
		map("<leader>dd", builtin.diagnostics, "[D]iagnostics [D]isplay")
		map("<leader>fe", function()
			file_browser({ path = "%:p:h" })
		end, "[F]ile [E]xplorer")
		map("<leader>f/", builtin.current_buffer_fuzzy_find, "[F]uzzily [/] search in current buffer")
	end,
}
