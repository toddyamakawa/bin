
local vim = vim

vim.api.nvim_create_autocmd('VimEnter', {
	callback = function()
		vim.api.nvim_command('terminal')
		vim.api.nvim_command('startinsert')
	end
})

vim.api.nvim_create_autocmd('TermEnter', {
	callback = function()
		--vim.o.statusline = '%#None#'
		vim.o.laststatus = 0
		vim.wo.list = false
		vim.wo.number = false
		vim.wo.relativenumber = false
		--vim.cmd('setlocal statusline=')

		--vim.o.signcolumn = false
		--vim.o.foldclolumn = false
	end
})

vim.api.nvim_create_autocmd('TermClose', {
	callback = function()
		--vim.cmd('silent! bd!')
		vim.cmd('quit!')
	end
})

vim.api.nvim_set_keymap('t', '<C-g>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<CR>', [[i<CR>]], { noremap = true, silent = true })

vim.opt.termguicolors = true
vim.cmd('colorscheme catppuccin_macchiato')

