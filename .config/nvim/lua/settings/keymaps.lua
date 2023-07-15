-------------------------------------------------
-- KEYBINDINGS
-------------------------------------------------

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements while in insert mode
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")
map("n", "<C-E>", "<ESC>A")
map("n", "<C-A>", "<ESC>I")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "<leader>p", "\"_dP")

map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

map("n", "<F3>", ":NvimTreeToggle<CR>")
map("n", "<F4>", ":NvimTreeFocus<CR>")

