return {
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
						completions = {
							completeFunctionCalls = true,
						},
						javascript = {
							suggest = {
								autoImports = true,
							},
						},
						typescript = {
							suggest = {
								autoImports = true,
							},
						},
					},
				},

				eslint = {
					settings = {
						codeAction = {
							disableRuleComment = {
								enable = true,
								location = "separateLine",
							},
							showDocumentation = {
								enable = true,
							},
						},
						codeActionOnSave = {
							enable = false,
						},
						format = true,
						onIgnoredFiles = "off",
						packageManager = "npm",
						quiet = false,
						rulesCustomizations = {},
						run = "onType",
						useESLintClass = false,
						validate = "on",
						workingDirectory = {
							mode = "auto",
						},
					},

					on_attach = function(client, bufnr)
						client.server_capabilities.codeActionProvider = false
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
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
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"jsx",
				"html",
				"css",
				"scss",
				"json",
				"jsonc",
				"markdown",
				"markdown_inline",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
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
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			autotag = {
				enable = true,
			},
		},
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
		},
	},

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
			})

			opts.formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					before = function(entry, vim_item)
						vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
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

	{
		"windwp/nvim-ts-autotag",
		ft = { "javascriptreact", "typescriptreact", "html" },
		config = true,
	},

	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"typescript-language-server",
				"eslint-lsp",
				"json-lsp",
				"html-lsp",
				"css-lsp",

				"prettierd",
				"eslint_d",

				"stylelint",
				"markdownlint",
			},
		},
	},
}
