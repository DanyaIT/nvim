return {
	-- =====================================================================
	-- LSP (via LazyVim typescript extra → uses vtsls)
	-- =====================================================================
	{ import = "lazyvim.plugins.extras.lang.typescript" },
	{ import = "lazyvim.plugins.extras.linting.eslint" },

	-- Additional LSP server overrides
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				vtsls = {
					settings = {
						typescript = {
							suggest = { autoImports = true },
							tsserver = { maxTsServerMemory = 4096 },
						},
						javascript = {
							suggest = { autoImports = true },
						},
					},
				},

				jsonls = {
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false
					end,
				},

				eslint = {
					settings = {
						workingDirectories = { mode = "auto" },
					},
				},
			},
		},
	},

	-- Readable TS errors in diagnostics
	{
		"dmmulroy/ts-error-translator.nvim",
		ft = { "typescript", "typescriptreact" },
		config = true,
	},

	-- =====================================================================
	-- Treesitter
	-- =====================================================================
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"scss",
				"json",
				"jsonc",
				"svelte",
				"scala",
				"markdown",
				"markdown_inline",
				"prisma",
			},
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
		},
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
		},
	},

	-- =====================================================================
	-- Completion (nvim-cmp)
	-- =====================================================================
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"onsails/lspkind.nvim",
			"dcampos/cmp-snippy",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"dmitmel/cmp-cmdline-history",
			"f3fora/cmp-spell",
		},
		opts = function(_, opts)
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			opts.sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "emoji" },
				{
					name = "spell",
					option = {
						keep_all_entries = false,
						enable_in_context = function()
							return true
						end,
						preselect_correct_word = true,
					},
				},
			})

			opts.formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					before = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							nvim_lsp_signature_help = "[Sig]",
							buffer = "[Buf]",
							path = "[Path]",
							emoji = "[Emoji]",
						})[entry.source.name]
						return vim_item
					end,
				}),
			}

			opts.mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
			})

			return opts
		end,
	},

	-- =====================================================================
	-- Mason
	-- =====================================================================
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"vtsls",
				"eslint-lsp",
				"json-lsp",
				"html-lsp",
				"css-lsp",
				"svelte-language-server",
				"prettierd",
				"stylelint",
				"markdownlint",
			},
		},
	},

	-- =====================================================================
	-- Formatting (prettier only — eslint-lsp handles lint fixes via code actions)
	-- =====================================================================
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				markdown = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 3000,
				lsp_fallback = false,
			},
		},
	},

	-- =====================================================================
	-- Template strings
	-- =====================================================================
	{
		"axelvc/template-string.nvim",
		event = "InsertEnter",
		ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		opts = {
			remove_template_string = true,
			restore_quotes = {
				normal = [[']],
				jsx = [["]],
			},
		},
	},

	-- =====================================================================
	-- LSP File Operations
	-- =====================================================================
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
}
