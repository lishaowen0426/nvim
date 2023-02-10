return function()
require('nvim-treesitter.configs').setup{
	ensure_installed = {'c', 'lua', 'cpp', 'cmake','bash', 'rust'},	
	
	highlight = {
		enable = true,
	},

	indent = {enable = true},
}
end
