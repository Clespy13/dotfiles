" ~/.vimrc

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/vim/plugins/')

Plug 'cpiger/NeoDebug'
"Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'kristijanhusak/vim-hybrid-material'

" All of your Plugins must be added before the following line
call plug#end()

set encoding=utf-8 fileencodings=
syntax on

" autocmd Filetype make setlocal 
 "noexpandtab <Plug>(fern-action-open:select)<ESC><BAR>:FernDo close<CR>

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)<ESC><CR>",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> k <Plug>(fern-action-mark-toggle)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> R <Plug>(fern-action-remove)
  nmap <buffer> B <Plug>(fern-action-save-as-bookmark)
  nmap <buffer> <nowait> < <Plug>(fern-action-collapse)
  nmap <buffer> <nowait> > <Plug>(fern-action-expand)
endfunction

nmap <F3> :Fern ./ -drawer -toggle <CR>
nmap <F1> :source %<CR>
nmap <F5> :NeoDebug<CR>

function! OpenTree() abort
  execute "Fern ./ -drawer -toggle"
endfunction

augroup fern-custom
autocmd!
autocmd FileType fern call FernInit()
augroup END

" Fern settings
let g:fern#renderer = "nerdfont"
let g:fern#mark_symbol                       = '*'
let g:fern#mapping#bookmark#disable_default_mappings = 0
let g:fern_disable_startup_warnings = 1
let g:fern_disable_default_mappings = 1

let g:termdebug_popup = 0
let g:termdebug_wide = 163

let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1
let g:cpp_attributes_highlight = 1

" Macros for neodebug
let g:neodbg_keymap_toggle_breakpoint  = '<F9>'         " toggle breakpoint on current line
let g:neodbg_keymap_next               = '<F10>'        " next
let g:neodbg_keymap_run_to_cursor      = '<C-F10>'      " run to cursor (tb and c)
let g:neodbg_keymap_jump               = '<C-S-F10>'    " set next statement (tb and jump)
let g:neodbg_keymap_step_into          = '<F11>'        " step into
let g:neodbg_keymap_step_out           = '<S-F11>'      " setp out
let g:neodbg_keymap_continue           = '<F5>'         " run or continue
let g:neodbg_keymap_print_variable     = '<C-P>'        " view variable under the cursor
let g:neodbg_keymap_stop_debugging     = '<S-F5>'       " stop debugging (kill)
let g:neodbg_keymap_toggle_console_win = '<F6>'         " toggle console window
let g:neodbg_keymap_terminate_debugger = '<C-C>'        " terminate debugger

let g:airline_theme = "hybrid"

" Shows the number of the lines
set number
" Set the column at 80 chars for coding style
set cc=80
" 
set t_Co=256
" Highlight the line currently selected
set cursorline
" Sets the characters to be displayed for tabs and spaces
set list
set listchars=tab:»·,trail:·,eol:⏎

" Setup indentation
set autoindent
set smartindent

" Allow the use of mouse in vim
set mouse=a
" Change title of vim according to the files opened
set title
" Show current row and column position
set ruler
" Show dotfiles
set hidden
" Set backspace to act as expected
set backspace=indent,eol,start
" Set paste toggle for good copy and paste
set pastetoggle=<F2>
" Set the background to dark
set bg=dark

" The cholorscheme of vim
" let ayucolor="dark"
colorscheme hybrid_reverse

" Configures the tabs to be 4 spaces and autoindent after {}
filetype plugin indent on
set tabstop=4
set shiftwidth=4
" Option to replace tabs with spaces
" set expandtab

" Allow arrow keys to jump from line to line
set whichwrap+=<,>

" per .git vim configs
" just `git config vim.settings "expandtab sw=4 sts=4"` in a git repository
" change syntax settings for this repository

let git_settings = system("git config --get vim.settings")
if strlen(git_settings)
exe "set" git_settings
endif

" Additional if terminal is alacritty to allow the use of the mouse
if $TERM == 'alacritty'
	set ttymouse=sgr
endif

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

if (has("termguicolors"))
  set termguicolors
endif

nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP
