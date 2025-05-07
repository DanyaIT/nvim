require("config.lazy")

--Deleting without save in buffer (n-mode)
vim.keymap.set("n", "dd", '"_dd', { noremap = true, silent = true })
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("n", "D", '"_D', { noremap = true, silent = true })
vim.keymap.set("n", "dw", '"_dw', { noremap = true, silent = true })

-- Deleting without save in buffer (v-mode)
vim.keymap.set("v", "d", '"_d', { noremap = true, silent = true })
vim.keymap.set("v", "x", '"_x', { noremap = true, silent = true })

-- Set vertical line
vim.api.nvim_set_option_value("colorcolumn", "120", { scope = "global" })
