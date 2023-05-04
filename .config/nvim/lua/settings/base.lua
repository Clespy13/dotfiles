local g = vim.g
local o = vim.o
local opt = vim.opt

o.termguicolors = true
o.background = "dark"

o.timeoutlen = 500
o.updatetime = 200

o.scrolloff = 4

o.number = true
o.numberwidth = 2
o.relativenumber = true -- turn to true to have count of numbers from cursor
o.signcolumn = "yes"
o.cursorline = true

o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = -1
o.list = true
o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

o.clipboard = "unnamedplus"

-- case insensitive searching unless capital letter or /C in search
o.ignorecase = true
o.smartcase = true

o.backup = false
o.writebacku = false
o.undofile = true
o.swapfile = false

o.history = 50

o.splitright = true
o.splitbelow = true

opt.mouse = "a"

g.mapleader = " "
g.maplocalleader = " "
