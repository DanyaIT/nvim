vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

--Checking spelling
vim.opt.spell = true
vim.opt.spelllang = { "en_us", "ru" }

--Deleting without save in buffer (n-mode)
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("n", "x", '"_x', { noremap = true })

-- Deleting without save in buffer (v-mode)
vim.keymap.set("v", "d", '"_d', { noremap = true, silent = true })
vim.keymap.set("v", "x", '"_x', { noremap = true, silent = true })

-- Set vertical line
vim.api.nvim_set_option_value("colorcolumn", "120", { scope = "global" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.inlayHintProvider = false
		end
	end,
})

-- Example: auto-delete swap files for unmodified buffers
vim.opt.swapfile = false -- or customize swap file behavior

require("config.lazy")
