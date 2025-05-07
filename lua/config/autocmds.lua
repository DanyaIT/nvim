vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
	callback = function()
		vim.lsp.buf.code_action({
			apply = true,
			context = {
				only = { "source.addMissingImports.ts" }, -- Фильтр для добавления импортов
			},
		})
	end,
})
