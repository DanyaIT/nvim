return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		"hrsh7th/nvim-cmp",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = { file_types = { "markdown", "Avante" } },
			ft = { "markdown", "Avante" },
		},
	},
	---@type avante.Config
	opts = {
		provider = "ollama",
		ollama = {
			model = "llama2:7b",
		},
	},
	config = function(_, opts)
		require("avante").setup(opts)

		vim.keymap.set("n", "<leader>ac", ":AvanteChat<CR>", { desc = "Open Avante Chat" })
		vim.keymap.set("v", "<leader>ae", ":AvanteEdit<CR>", { desc = "Edit selection with Avante" })
	end,
}
