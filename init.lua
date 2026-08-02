-- Entry point for nvim configurations

-- Load Core Settings (options, keymaps, autocmds) 
	
	require("config.options") -- vim.opt settings
	require("config.keymaps") -- vim.keymap.set bindings
	require("config.autocmd") -- vim.api.nvim_create_autocmd (mainly used fo file type configurations)



-- Bootstrap lazy.nvim and load plugins
require("config.Lazy")
