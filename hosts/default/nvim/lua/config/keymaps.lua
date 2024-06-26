--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: config/keymaps.lua
-- Description: Key mapping configs
-- Close all windows and exit from Neovim with <leader> and q
vim.keymap.set("n", "<leader>q", ":qa!<CR>", {})
-- Fast saving with <leader> and s
vim.keymap.set("n", "<leader>s", ":w<CR>", {})
-- Move around splits
vim.keymap.set("n", "<leader>wh", "<C-w>h", {})
vim.keymap.set("n", "<leader>wj", "<C-w>j", {})
vim.keymap.set("n", "<leader>wk", "<C-w>k", {})
vim.keymap.set("n", "<leader>wl", "<C-w>l", {})

-- Reload configuration without restart nvim
vim.keymap.set("n", "<leader>r", ":so %<CR>", {})

-- Telescope
-- <leader> is a space now
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- NvimTree
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", {}) -- open/close
--vim.keymap.set("n", "<leader>nr", ":NvimTreeRefresh<CR>", {}) -- refresh
--vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>", {}) -- search file

-- Terminal
vim.keymap.set("n", "<leader>t", ":NeotermToggle<CR>", {})
-- vim.keymap.set("n", "<leader>tx", ":NeotermExit<CR>", {})

-- Tmux
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", {})
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", {})

local opts = { noremap=true, silent=true }

local function quickfix()
  vim.lsp.buf.code_action({
      filter = function(a) return a.isPreferred end,
      apply = true
  })
end

vim.keymap.set('n', '<leader>qf', quickfix, opts)

