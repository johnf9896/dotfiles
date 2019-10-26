" Specify a directory for plugins
if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged_coc')
else
    call plug#begin('~/.vim/plugged_coc')
endif

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'vimwiki/vimwiki', {'branch': 'dev'}
Plug 'tbabej/taskwiki'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-system-copy'
Plug 'Raimondi/delimitMate'
Plug 'lag13/ReplaceWithRegister'
Plug 'michaeljsmith/vim-indent-object'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-scripts/argtextobj.vim'
Plug 'kshenoy/vim-signature'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

if has('nvim')
    Plug 'voldikss/vim-floaterm'
else
    Plug 'rhysd/vim-healthcheck'
endif

" Initialize plugin system
call plug#end()

syntax on
filetype plugin indent on

" set clipboard=unnamedplus
colorscheme ron

" Enable hidden buffers
set hidden

set exrc
set number
set mouse=a
set background=dark
set cursorline
set lazyredraw
set showmatch
set listchars=tab:▸\ ,eol:¬,trail:-,nbsp:+
set updatetime=500
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set expandtab
set ignorecase
set splitbelow " Open new split panes to right and bottom, which feels more natural
set splitright
set completeopt=menu,preview,noinsert " Do not insert first suggestion
set timeoutlen=350
set ttimeoutlen=50
set relativenumber " Show relative number lines
set cmdheight=2

" Enable persistent undo so that undo history persists across vim sessions
if has('nvim')
    set undodir=~/.local/share/nvim/undo
else
    set undodir=~/.vim/undo

    " Create directory if it doesn't exist (NeoVim creates it automatically)
    if !isdirectory(&undodir)
        call mkdir(&undodir)
    end
endif

set undofile

" ------------------------ Settings for NeoVim only  -----------------"

if has('nvim')
    set inccommand=split
endif

" -------------------- End of settings for NeoVim only  --------------"

" ------------------------ Settings intended for Vim only (not NeoVim) -----------------"
" These are here because they are defaults in NeoVim or just don't exist at
" all

" Neovim's default history is already 10000 but Vim's is 50
set history=10000

" Always show the statusline
set laststatus=2

" Set to auto read when a file is changed from the outside
set autoread

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set showcmd             " show the partially entered command

set backspace=2 " Allow all backspacing options
set ruler
set smarttab
set autoindent " Inherit indentation when inserting a new line

" Zsh like <Tab> completion in command mode
set wildmenu

" Settings that don't exist in NeoVim
if !has('nvim')
    set t_Co=256
endif

if has('gui_running')
    " Mouse
    set mousehide
    set mousemodel=popup
endif

" -------------------- End of settings intended for Vim only (not NeoVim) --------------"

let mapleader = ","
let maplocalleader = "ñ"

" Open Vim RC and load automatically
autocmd BufWritePost vimrc,init.vim,.vimrc source $MYVIMRC
nmap <leader>ñ :tabedit $MYVIMRC<CR>

" Window navigation mappings
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Tab navigation
nnoremap <silent> <leader>1 :tabnext 1<CR>
nnoremap <silent> <leader>2 :tabnext 2<CR>
nnoremap <silent> <leader>3 :tabnext 3<CR>
nnoremap <silent> <leader>4 :tabnext 4<CR>
nnoremap <silent> <leader>5 :tabnext 5<CR>
nnoremap <silent> <leader>9 :tablast<CR>

" Use 'H' and 'L' keys to move to start/end of the line
noremap H g^
noremap L g$

" Use the arrow keys for window resizing
nnoremap <Up> <C-W>-
nnoremap <Down> <C-W>+
nnoremap <Left> <C-W><
nnoremap <Right> <C-W>>

vnoremap <Up> <C-W>-
vnoremap <Down> <C-W>+
vnoremap <Left> <C-W>>
vnoremap <Right> <C-W><

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?
nnoremap <leader><space> :nohlsearch<CR>

" Map Ctrl+C to copy to clipboard in Visual mode
" Added back to be used in minimal.vim
vmap <C-C> "+y

" Map Ctrl+V to paste (selection) in Insert mode
imap <C-V> <C-R>*

" Map Ctrl-V Ctrl-V to the default behavior of Ctrl-V
inoremap <C-V><C-V> <C-V>

" Paste from clipboard in normal mode in addition to system-copy mappings
nmap <leader>p "+p
nmap <leader>P "+P

" Replace selected text and keep the registry contents
" it's a capital 'p' on the end
xmap r "_dP

" Do the same but pasting from the clipboard
xmap <leader>r "_d"+P

" Replace line without overriding the register
" Commented out because ReplaceWithRegister already provides this functionality
" Will be added back in minimal.vim
" nnoremap <leader>r "_ddP

" Normalize Y behavior to yank till the end of line
nnoremap Y y$

" Toggle relative numbers
nnoremap <silent> <leader>r :set relativenumber!<CR>

" Buffer shortcuts
nmap <leader>n :enew<CR>
" Move to the next buffer
nmap <leader>l :bnext<CR>
" " Move to the previous buffer
nmap <leader>h :bprevious<CR>
" " Close the current buffer and move to the previous one
" " This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
" " Show all open buffers with FZF
nmap <leader>bb :Buffers<CR>
" Move to the alternative buffer
nmap <leader>ba :b#<CR>

" Edit files in the current file's directory
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Open FZF file finder
map <leader>f :Files<CR>

" Do not open Vim's help with F1
map <F1> <Nop>
imap <F1> <Nop>

if has('nvim')
    " Map <F1> to exit terminal-mode
    tnoremap <F1> <C-\><C-n>
endif

" Copy file basename only, file path, dirname
command! -nargs=0 CopyFileName let @+ = expand("%:t") | echo 'Copied to clipboard: ' . @+
command! -nargs=0 CopyFilePath let @+ = expand("%:p:~") | echo 'Copied to clipboard: ' . @+
command! -nargs=0 CopyFileDir let @+ = expand("%:p:~:h") | echo 'Copied to clipboard: ' . @+

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Remap [] to {} for latam keyboards
nmap { [
nmap } ]
omap { [
omap } ]
xmap { [
xmap } ]

" Map <localleader> { and } to the default behavior of { and }
nnoremap <localleader>{ {
nnoremap <localleader>} }
vnoremap <localleader>{ {
vnoremap <localleader>} }

" Create a W command to write because I keep typing :W (:Windows) instead of :w
command! -nargs=0 W write
command! -nargs=0 Q quit
command! -nargs=0 Qa quitall

" Use XX to exit Vim in normal mode
nmap <silent> XX :quitall<CR>

" Format JSON using Python's json.tool
command! -nargs=0 FormatJson %!python -m json.tool

autocmd Filetype make setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype html,javascript,scss,ruby,elixir setlocal ts=2 sts=2 sw=2
autocmd FileType haskell setlocal ts=4 sts=4 sw=4 expandtab

set wildignore=Ui_*,*.git,*.pyc
set wildignore+=*/vendor/**
set wildignore+=*/node_modules/**
set wildignore+=*/public/forum/**
set wildignore+=*/deps/**
set wildignore+=*/_build/**

let g:coc_global_extensions = ['coc-explorer', 'coc-git', 'coc-highlight', 'coc-snippets', 'coc-json', 'coc-yaml', 'coc-tsserver', 'coc-html', 'coc-css', 'coc-vimlsp', 'coc-rls', 'coc-python']
nmap <silent> <leader>d <Plug>(coc-definition)
autocmd CursorHold * silent call CocActionAsync('highlight')
map <F5> :CocCommand explorer<CR>

"Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1

" Gitgutter
nmap <silent> }c <Plug>(coc-git-nextchunk)
nmap <silent> {c <Plug>(coc-git-prevchunk)
nmap <silent> <Leader>cs :CocCommand git.chunkStage<CR>
nmap <silent> <Leader>cu :CocCommand git.chunkUndo<CR>
nmap <silent> <Leader>cp <Plug>(coc-git-chunkinfo)
highlight GitGutterAdd    guifg=#009900 ctermfg=80
highlight GitGutterChange guifg=#bbbb00 ctermfg=116
highlight GitGutterDelete guifg=#ff2222 ctermfg=200

" Fugitive mapping
nmap <leader>gb :Gblame<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gg :Ggrep
nmap <leader>gL :Glog<cr>
nmap <leader>gl :Git pull<cr>
nmap <leader>gp :Git push<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gw :Gbrowse<cr>

" Git Messenger
nmap <Leader>gm <Plug>(coc-git-commit)

" Normal color in popup window with custom colors
highlight gitmessengerPopupNormal term=None guifg=#eeeeee guibg=#333333 ctermfg=255 ctermbg=234

" Header such as 'Commit:', 'Author:' with 'Statement' highlight group
highlight link gitmessengerHeader Statement

" Commit hash at 'Commit:' header with 'Special' highlight group
highlight link gitmessengerHash Special

" History number at 'History:' header with 'Title' highlight group
highlight link gitmessengerHistory Title

" EasyMotion
let g:EasyMotion_keys = 'asdfghjklqwertyuiopzxcvbnmñ'
let g:EasyMotion_startofline = 0
map ¿ <Plug>(easymotion-prefix)
map ĵ <Plug>(easymotion-j)
map Ĵ <Plug>(easymotion-sol-j)
map ķ <Plug>(easymotion-k)
map Ķ <Plug>(easymotion-sol-k)
map ẁ <Plug>(easymotion-w)
map Ẁ <Plug>(easymotion-W)
map ḃ <Plug>(easymotion-b)
map Ḃ <Plug>(easymotion-B)
map ş <Plug>(easymotion-s)
map ť <Plug>(easymotion-t)
map Ť <Plug>(easymotion-T)
map ḟ <Plug>(easymotion-f)
map Ḟ <Plug>(easymotion-F)

" Mundo
nnoremap <silent> <F6> :MundoToggle<CR>

" System copy
let g:system_copy#copy_command='xclip -sel clipboard'
let g:system_copy#paste_command='xclip -sel clipboard -o'

" Ack - Ag
let g:ackprg = 'ag --vimgrep'

" AsyncRun
let g:asyncrun_open = 8

" Highlighted Yank
let g:highlightedyank_highlight_duration = 300

let g:SignatureMarkTextHLDynamic = 1

" Floaterm
let g:floaterm_background = '#000000'
noremap  <silent> <F10> :FloatermToggle<CR>i
noremap! <silent> <F10> <Esc>:FloatermToggle<CR>i
tnoremap <silent> <F10> <C-\><C-n>:FloatermToggle<CR>

" VimWiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" TaskWiki
let g:taskwiki_markup_syntax = 'markdown'

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Elixir
let g:ale_elixir_elixir_ls_release = '/home/jhon/code/lib/elixir-ls/rel'
let g:ale_elixir_elixir_ls_config = {
            \   'elixirLS': {
            \     'dialyzerEnabled': v:false,
            \   },
            \}

" Wrap word in {:ok, word} tuple
autocmd FileType elixir nmap <silent> <localleader>o :call <SID>NormalWrap("{:ok, ", "}")<CR>
autocmd FileType elixir xmap <silent> <localleader>o :call <SID>VisualWrap("{:ok, ", "}")<CR>

" Wrap word in {:error, word} tuple
autocmd FileType elixir nmap <silent> <localleader>e :call <SID>NormalWrap("{:error, ", "}")<CR>
autocmd FileType elixir xmap <silent> <localleader>e :call <SID>VisualWrap("{:error, ", "}")<CR>

" Rust
let g:rustfmt_autosave = 1

" MatchTagAlways
nnoremap <leader>% :MtaJumpToOtherTag<CR>

" JavaScript
let g:jsx_ext_required=0                     " jsx highlighting in .js files

" Haskell

" ----- neovimhaskell/haskell-vim -----

" Align 'then' two spaces after 'if'
let g:haskell_indent_if = 2
" Indent 'where' block two spaces under previous body
let g:haskell_indent_before_where = 2
" Allow a second case indent style (see haskell-vim README)
let g:haskell_indent_case_alternative = 1
" Only next under 'let' if there's an equals sign
let g:haskell_indent_let_no_in = 0

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" Ale
"let g:ale_linters = {
"\'rust': ['rls'],
"\'haskell': ['hie', 'hlint']
"\}

let g:ale_linters = {
            \'rust': ['rls'],
            \'cpp': ['gcc', 'cppcheck'],
            \'elixir': ['credo', 'elixir-ls', 'dialyxir'],
            \}

let g:ale_cpp_gcc_options = '-std=c++17 -Wall'

" let g:ale_completion_enabled = 1
let g:ale_set_ballons = 1
set omnifunc=ale#completion#OmniFunc
let g:airline#extensions#ale#enabled = 1

" Ale mappings
nmap <leader>dd :ALEGoToDefinition<CR>
nmap <leader>ds :ALEGoToDefinitionInSplit<CR>
nmap <leader>dv :ALEGoToDefinitionInVSplit<CR>
nmap <leader>dt :ALEGoToDefinitionInTab<CR>

au BufNewFile,BufRead Dockerfile* setlocal ft=dockerfile
au BufNewFile,BufRead Jenkinsfile* setlocal ft=groovy

set secure

" ------------------------ Utility functions ----------------------"

" Wrap the current word in some text
function! s:NormalWrap(before, after)
    silent DelimitMateOff
    execute "normal bi" . a:before . "ea" . a:after . ""
    silent DelimitMateOn
endfunction

" Wrap the selected text in some text
function! s:VisualWrap(before, after) range
    let start = getpos("'<")
    let end = getpos("'>")

    silent DelimitMateOff
    call setpos('.', end)
    execute "normal a" . a:after . ""
    call setpos('.', start)
    execute "normal i" . a:before . ""
    silent DelimitMateOn
endfunction
