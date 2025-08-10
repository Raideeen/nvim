-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Code action
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Apply [C]ode [A]ctions' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Window management keybindings
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = '[W]indow move left' })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = '[W]indow move down' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = '[W]indow move up' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = '[W]indow move right' })
vim.keymap.set('n', '<leader>ws', '<C-w>s', { desc = '[W]indow [S]plit horizontal' })
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = '[W]indow split [V]ertical' })
vim.keymap.set('n', '<leader>wq', '<C-w>q', { desc = '[W]indow [Q]uit' })
vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = '[W]indow [O]nly (close others)' })
vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = '[W]indow next [W]indow' })
vim.keymap.set('n', '<leader>wr', '<C-w>r', { desc = '[W]indow [R]otate' })
vim.keymap.set('n', '<leader>wx', '<C-w>x', { desc = '[W]indow e[X]change' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = '[W]indow equalize' })

-- Hovering
vim.keymap.set('n', '<leader>k', function()
  vim.lsp.buf.hover { focus = true, focusable = true }
end, { desc = 'Hover definition under cursor' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
