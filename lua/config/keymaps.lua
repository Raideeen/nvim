-- [[ Set up keymaps ]] See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Use <Esc> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ "t", "i" }, "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set({ "t", "i" }, "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set({ "t", "i" }, "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set({ "t", "i" }, "<C-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set({ "n" }, "<C-h>", "<C-w>h")
vim.keymap.set({ "n" }, "<C-j>", "<C-w>j")
vim.keymap.set({ "n" }, "<C-k>", "<C-w>k")
vim.keymap.set({ "n" }, "<C-l>", "<C-w>l")

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Open link under cursor
vim.keymap.set("n", "<leader>jl", "<C-]>", { desc = "[J]ump to help tag [l]ink" })
vim.keymap.set("n", "<leader>jb", "<C-o>", { desc = "[J]ump [b]ack to original help tag" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Code action
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Apply [C]ode [A]ctions" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Window management keybindings
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "[W]indow move left" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "[W]indow move down" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "[W]indow move up" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "[W]indow move right" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "[W]indow [S]plit horizontal" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "[W]indow split [V]ertical" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "[W]indow [Q]uit" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "[W]indow [O]nly (close others)" })
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "[W]indow next [W]indow" })
vim.keymap.set("n", "<leader>wr", "<C-w>r", { desc = "[W]indow [R]otate" })
vim.keymap.set("n", "<leader>wx", "<C-w>x", { desc = "[W]indow e[X]change" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "[W]indow equalize" })

-- Hovering
vim.keymap.set("n", "<leader>k", function()
	vim.lsp.buf.hover({ focus = true, focusable = true })
end, { desc = "Hover definition under cursor" })
