call plug#begin('~/.config/nvim/plugged')
" Plugins {
    " ctrl-p is a fuzzy file finder.
    Plug 'kien/ctrlp.vim'
    " lightline is a status line for nvim.
    Plug 'itchyny/lightline.vim'
    " gruvbox colorscheme. Seems to work the best for me.
    Plug 'morhetz/gruvbox'
    " autocomplete for everything
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " syntax file
    Plug 'HerringtonDarkholme/yats.vim'
" }

call plug#end()

" Map the leader key to ,
let mapleader="\<SPACE>"

" General {
    set noautoindent        " I indent my code myself.
    set nocindent           " I indent my code myself.
    set smartindent        " Or I let the smartindent take care of it.
    set breakindent         " Indent line-breaks at the same level as code.
    set ttimeoutlen=100
" }

" Search {
    set ignorecase          " Make searching case insensitive
    set smartcase           " ... unless the query has capital letters.
    set gdefault            " Use 'g' flag by default with :s/foo/bar/.

    " Use <C-L> to clear the highlighting of :set hlsearch.
    if maparg('<C-L>', 'n') ==# ''
        nnoremap <silent> <C-L> :nohlsearch<cr><C-L>
    endif

    nmap <leader>s :%s//g<left><left>
" }

" Formatting {
    set showmatch           " Show matching brackets.
    set number              " Show the line numbers on the left side.
    set formatoptions+=o    " Continue comment marker in new lines.
    set expandtab           " Insert spaces when TAB is pressed.
    set tabstop=4           " Render TABs using this many spaces.
    set shiftwidth=4        " Indentation amount for < and > commands.

    set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

    set splitbelow          " Horizontal split below current.
    set splitright          " Vertical split to right of current.

    if !&scrolloff
        set scrolloff=3       " Show next 3 lines while scrolling.
    endif
    if !&sidescrolloff
        set sidescrolloff=5   " Show next 5 columns while side-scrolling.
    endif
    set nostartofline       " Do not jump to first character with page commands.
" }

" Configuration {
    function! TrimWhitespace()
        let l:save = winsaveview()
        %s/\s\+$//e
        call winrestview(l:save)
    endfunction

    " we might not want to call this all the time
    autocmd BufWritePre * call TrimWhitespace()
    nnoremap <leader>W :call TrimWhitespace()<cr>
" }

" UI Options {

    " colorscheme options
    set bg=dark
    colorscheme gruvbox

    " hightlight extra whitespace
    highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
    match ExtraWhitespace /\s\+$\|\t/

    " relative numbers
    function! NumberToggle()
        if(&relativenumber == 1)
            set nornu
            set number
        else
            set rnu
        endif
    endfunc

    " toggle between normal and relative numbering
    nnoremap <leader>r :call NumberToggle()<cr>
" }
"
" Key Mappings {
    " easy commands
    nmap ; :
    vmap ; :

    " easy saving
    nmap <leader>fs :w!<cr>

    " quickly open config
    nmap <leader>fed :e ~/AppData/Local/nvim/init.vim<cr>

    " Save file
    nmap <leader>w :w<cr>

    " hack for quickly editing files
    nmap <F5> :e ~/projects/screeps-tdd/src/affairs.ts<cr>

    " copy and paste from the system cliboard
    vmap <leader>y "+y
    vmap <leader>d "+d
    nmap <leader>p "+p
    nmap <leader>P "+P
    vmap <leader>p "+p
    vmap <leader>P "+P

    " move between buffers
    nmap <leader>l :bnext<cr>
    nmap <leader>h :bprevious<cr>
    nmap <leader>k :tabnext<cr>
    nmap <leader>j :tabprevious<cr>
    nmap <tab> <C-w>w

    " move between tabs nicely
    nmap <leader>wh <C-w>h<cr>
    nmap <leader>wj <C-w>j<cr>
    nmap <leader>wk <C-w>k<cr>
    nmap <leader>wl <C-w>l<cr>

    " manage split sizes
    map <leader>ww <C-w>_
    map <leader>w\ <C-w>|
    map <leader>we <C-w>=
    map <leader>w- <C-w>-
    map <leader>w= <C-w>+

    " go to top and bottom of the file
    nnoremap <cr> G
    nnoremap <BS> gg

    " stop cursor from jumping over wrapped lines
    nnoremap j gj
    nnoremap k gk
" }

" Plugin Settings {
    " CtrlP {
        " Open file menu
        nnoremap <leader>o :CtrlP<cr>
        " Open buffer menu
        nnoremap <leader>b :CtrlPBuffer<cr>
        " Open most recently used files
        nnoremap <leader>f :CtrlPMRUFiles<cr>
    " }
" }

