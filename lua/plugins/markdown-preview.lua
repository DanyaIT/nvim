return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = "cd app && npm install",
	init = function()
		vim.g.mkdp_auto_close = 1
		vim.g.mkdp_open_to_the_world = 0
		vim.g.mkdp_open_ip = "127.0.0.1"
		vim.g.mkdp_port = 8090
		vim.g.mkdp_browser = ""
		vim.g.mkdp_echo_preview_url = 1
		vim.g.mkdp_preview_options = {
			mkit = {},
			katex = {},
			uml = {},
			maid = {},
			disable_sync_scroll = 0,
			sync_scroll_type = "middle",
		}
	end,
	keys = {
		{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
	},
}
