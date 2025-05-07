-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
	{
		"Mofiqul/vscode.nvim",
		priority = 1000, -- Важно для корректной загрузки
		config = function()
			require("vscode").setup({
				-- Опции (можно настроить под себя)
				transparent = false,
				italic_comments = true,
			})
			vim.cmd.colorscheme("vscode")
		end,
	},
}
