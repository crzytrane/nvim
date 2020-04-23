call plug#begin('~/.config/nvim/plugged')
" Plugins {
    " ctrl-p is a fuzzy file finder.
    Plug 'kien/ctrlp.vim'
    " lightline is a status line for nvim.
    Plug 'itchyny/lightline.vim'
    " gruvbox colorscheme. Seems to work the best for me.
    Plug 'morhetz/gruvbox'

    " vim wiki
    " Plug 'vimwiki/vimwiki'

    " autocomplete for everything
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " syntax file
    Plug 'HerringtonDarkholme/yats.vim'
" }

call plug#end()

" Map the leader key to ,
let mapleader="\<SPACE>"

" Help {
    " load custom help files
    helptags ~/AppData/Local/nvim/doc
" }

" General {
    set noautoindent        " I indent my code myself.
    set nocindent           " I indent my code myself.
    set smartindent         " Or I let the smartindent take care of it.
    set breakindent         " Indent line-breaks at the same level as code.
    set ttimeoutlen=100

    set nocompatible
    filetype plugin on
    syntax on
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
    " nmap <leader>wh <C-w>h
    " nmap <leader>wj <C-w>j
    " nmap <leader>wk <C-w>k
    " nmap <leader>wl <C-w>l

    tnoremap <A-h> <C-\><C-N><C-w>h
    tnoremap <A-j> <C-\><C-N><C-w>j
    tnoremap <A-k> <C-\><C-N><C-w>k
    tnoremap <A-l> <C-\><C-N><C-w>l
    inoremap <A-h> <C-\><C-N><C-w>h
    inoremap <A-j> <C-\><C-N><C-w>j
    inoremap <A-k> <C-\><C-N><C-w>k
    inoremap <A-l> <C-\><C-N><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

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

    " get quick help
    nmap <leader>? :help crzytrane<cr>
" }

" Plugin Settings {
    " Coc {
        nmap <leader><leader> :CocCommand<cr>
    " }
    " CtrlP {
        " Open file menu
        nnoremap <leader>o :CtrlP<cr>
        " Open buffer menu
        nnoremap <leader>b :CtrlPBuffer<cr>
        " Open most recently used files
        nnoremap <leader>f :CtrlPMRUFiles<cr>
    " }
" }

" Coc Settings {
    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
    set cmdheight=2

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    "" if exists('*complete_info')
    "" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    "" else
    "" imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    "" endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current line.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Introduce function text object
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <TAB> for selections ranges.
    " NOTE: Requires 'textDocument/selectionRange' support from the language server.
    " coc-tsserver, coc-python are the examples of servers that support it.
    nmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <TAB> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Mappings using CoCList:
    " Show all diagnostics.
    nnoremap <silent> ,a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> ,e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent> ,c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent> ,o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> ,s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> ,j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> ,k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent> ,p  :<C-u>CocListResume<CR>

" }
