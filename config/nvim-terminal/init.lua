
vim.api.nvim_create_autocmd('VimEnter', {
	callback = function()
		vim.o.laststatus = 0
		vim.api.nvim_command('terminal')
		vim.api.nvim_command('startinsert')
	end
})

vim.api.nvim_create_autocmd('TermClose', {
	callback = function(event)
		vim.cmd('quit')
	end
})

vim.api.nvim_set_keymap('t', '<C-g>', [[<C-\><C-n>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<CR>', [[i<CR>]], { noremap = true, silent = true })

