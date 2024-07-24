-- Todo Comments
require("todo-comments").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
	update_interval = 3000,
	set_dark_mode = function()
		vim.api.nvim_set_option('background', 'dark')
		vim.cmd('colorscheme nord')
	end,
	set_light_mode = function()
		vim.api.nvim_set_option('background', 'light')
		vim.cmd('colorscheme one')
	end,
})

require('lualine').setup {
	options = {
		icons_enabled = false,
	}
}
