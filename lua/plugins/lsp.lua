return {
	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/typescript.nvim",
			"pmizio/typescript-tools.nvim",
			"dmmulroy/ts-error-translator.nvim",
		},
		opts = {
			servers = {
				tsserver = {
					settings = {
						completions = { completeFunctionCalls = true },
						javascript = { suggest = { autoImports = true } },
						typescript = { suggest = { autoImports = true } },
					},
				},

				jsonls = {
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false
					end,
				},
			},
			setup = {
				tsserver = function(_, opts)
					require("typescript").setup({ server = opts })
					require("ts-error-translator").setup()
					return true
				end,
			},
		},
	},

	{ import = "lazyvim.plugins.extras.lang.typescript" },

	-- =====================================================================
	-- Treesitter
	-- =====================================================================
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"html",
				"css",
				"scss",
				"json",
				"svelte",
				"scala",
				"jsonc",
				"markdown",
				"markdown_inline",
				"ejs",
				"prisma",
				"yml",
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
			context_commentstring = { enable = true, enable_autocmd = false },
			autotag = { enable = true },
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
			"amarakon/nvim-cmp-fonts",
			"dmitmel/cmp-cmdline-history",
			"hrsh7th/cmp-nvim-lsp-signature-help",
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
				"typescript-language-server",
				"json-lsp",
				"html-lsp",
				"css-lsp",
				"svelte-language-server",
				"prettierd",
				"eslint_d",
				"stylelint",
				"markdownlint",
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
	-- Formatting (Conform) — ONLY Prettier
	-- =====================================================================
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
			},
			format_on_save = {
				async = true,
				timeout_ms = 500,
				lsp_fallback = false,
			},
		},
	},

	-- =====================================================================
	-- Linting (nvim-lint) — ONLY ESLint diagnostics
	-- =====================================================================
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
			}

			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
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
