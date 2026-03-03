syntax on

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'  " file list
Plug 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing
" If you want to have icons in your statusline choose one of these
Plug 'luochen1990/rainbow'  " colors for delimiters
Plug 'nvim-lualine/lualine.nvim' " nicer status bar but in Lua
Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
Plug 'ludovicchabant/vim-gutentags' " manages your tag files
Plug 'Yggdroot/indentLine'  " show indentation lines
Plug 'Raimondi/delimitMate'  " autocompletion for delimiters
Plug 'tpope/vim-surround'  " add or delete delimiters TODO: learn how to use this!
Plug 'ryanoasis/vim-devicons'  " cool icons
Plug 'junegunn/fzf.vim' " TODO: learn
"Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

"Plug 'dense-analysis/ale' TODO: maybe enable it?? or find a way to have with CoC
Plug 'morhetz/gruvbox'

" C/C++ and low-level stuff
Plug 'tikhomirov/vim-glsl'

" Python stuff
Plug 'Vimjas/vim-python-pep8-indent'  "better indenting for python

 " path to directory where library can be found
let g:clang_library_path='/usr/lib/llvm15/lib'
let g:rainbow_active = 1
let g:sql_type_default = 'pgsql'

call plug#end()

" path to your python
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python'

filetype indent on

set fileformat=unix
set shortmess+=c

set mouse=a  " change cursor per mode
set number  " always show current line number
set wrapscan  " begin search from top of file when nothing is found anymore

set expandtab
set tabstop=4
set shiftwidth=4
set fillchars+=vert:\  " remove chars from seperators
set softtabstop=4

set history=1000  " remember more commands and search history

set breakindent  " preserve horizontal whitespace when wrapping
set showbreak=..
set nowrap  " i turn on wrap manually when needed

set scrolloff=3 " keep three lines between the cursor and the edge of the screen

set undodir=~/.vim/undodir
set undofile  " save undos
set undolevels=10000  " maximum number of changes that can be undone
set undoreload=100000  " maximum number lines to save for undo on a buffer reload

set noshowmode  " keep command line clean
set noshowcmd

set laststatus=2  " always slow statusline

set splitright  " i prefer splitting right and below
set splitbelow

set hlsearch  " highlight search and search while typing
set incsearch
set cpoptions+=x  " stay at seach item when <esc>

set noerrorbells  " remove bells (i think this is default in neovim)
set visualbell
set t_vb=
set relativenumber
set viminfo='20,<1000  " allow copying of more than 50 lines to other applications


let mapleader = " " " Leader is the space key
let g:mapleader = " "
let maplocalleader = "`"
let g:maplocalleader = "`"
nnoremap <SPACE> <Nop>

nnoremap("<leader>p", "\"_dP")

" magma
nnoremap <silent><expr> <Leader>r  :MagmaEvaluateOperator<CR>
nnoremap <silent> <Leader>rr :MagmaEvaluateLine<CR>
xnoremap <silent> <C-Enter> :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent> <C-Enter> :MagmaReevaluateCell<CR>
nnoremap <silent> <Leader>rd :MagmaDelete<CR>
nnoremap <silent> <Leader>ro :MagmaShowOutput<CR>

let g:magma_automatically_open_output = v:false
let g:magma_image_provider = "ueberzug"

" function MagmaInitPython()
"     vim.cmd[[
"     :MagmaInit python3
"     :MagmaEvaluateArgument a=5
"     ]]
" end
" 
" vim.cmd[[ :command MagmaInitPython lua MagmaInitPython() ]]


" tabs:
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" mapping Esc
imap <F13> <Esc>
cnoremap <Esc> <C-c>
inoremap <c-c> <ESC>
nnoremap <C-z> <Esc>  " disable terminal ctrl-z

" map S to replace current word with pasteboard
nnoremap S diw"0P
nnoremap cc "_cc

" map paste, yank and delete to named register so the content
" will not be overwritten (I know I should just remember...)
nnoremap x "_x
vnoremap x "_x

" set clipboard=unnamedplus

map <C-n> :NERDTreeToggle<CR>
map <C-t> :set nosplitright<CR>:TagbarToggle<CR>:set splitright<CR>

"auto indent for brackets
nmap <leader>w :w!<cr>
nmap <leader>q :lcl<cr>:q<cr>
nnoremap <leader>h :nohlsearch<Bar>:echo<CR>

set timeoutlen=500

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" easy breakpoint python
au FileType python map <silent> <leader>b ofrom pudb import set_trace; set_trace()<esc>
au FileType python map <silent> <leader>B Ofrom pudb import set_trace; set_trace()<esc>
au FileType python map <silent> <leader>j ofrom pdb import set_trace; set_trace()<esc>
au FileType python map <silent> <leader>J Ofrom pdb import set_trace; set_trace()<esc>

highlight VertSplit ctermbg=253

" highlight python and self function
autocmd BufEnter * syntax match Type /\v\.[a-zA-Z0-9_]+\ze(\[|\s|$|,|\]|\)|\.|:)/hs=s+1
autocmd BufEnter * syntax match pythonFunction /\v[[:alnum:]_]+\ze(\s?\()/
hi def link pythonFunction Function
autocmd BufEnter * syn match Self "\(\W\|^\)\@<=self\(\.\)\@="
highlight self ctermfg=239

" jedi options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 1
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures_modes = 'i'  " ni = also in normal mode
let g:jedi#enable_speed_debugging=0

" Impsort option
hi pythonImportedObject ctermfg=127
hi pythonImportedFuncDef ctermfg=127
hi pythonImportedClassDef ctermfg=127

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" neovim options
" au BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <C-a> <Esc>
nnoremap <C-x> <Esc>

" vimgutter options
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

" A E S T H E T I C S
colorscheme gruvbox
hi Normal ctermbg=NONE guibg=NONE

set redrawtime=1000

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

set clipboard=unnamedplus


lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
require('lualine').setup()
END
