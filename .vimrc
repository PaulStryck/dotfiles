" load sensible defaults here to allow overriding
runtime! plugin/sensible.vim

set nocompatible

" Set fzf runtime
set rtp+=/usr/local/opt/fzf


" Colorscheme see https://github.com/hukl/Smyck-Color-Scheme
color smyck

" Add line numbers
set number
set cursorline

" Disable Backup and Swap files
set noswapfile
set nobackup
set nowritebackup

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Disable Mode Display because Status line is on
set noshowmode

" Show trailing spaces and highlight hard tabs
" this overrides settings from vim-sensible
set list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:+

" Strip trailing whitespaces on each save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    " dont remove whitespace from markdown files
    if &ft =~ 'markdown'
        return
    endif

    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Close window if last remaining window is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Search related settings
set hlsearch

nnoremap <silent> <C-p> :<C-u>GFiles<CR><C-p>

" Highlight characters behind the 80 chars margin
:au BufWinEnter * let w:m2=matchadd('ColumnMargin', '\%>80v.\+', -1)

" Highlight Column in lines exceeding the line limit set in .editorconf
let g:EditorConfig_max_line_indicator = "exceeding"

" Disable code folding
set nofoldenable


" set vim and tmux window switch shortcuts
let g:tmux_navigator_no_mappings = 1

" map xterm key sequences explicitly because tmux uses screen
nnoremap <silent> <ESC>[1;6A :TmuxNavigateUp<cr>
nnoremap <silent> <ESC>[1;6B :TmuxNavigateDown<cr>
nnoremap <silent> <ESC>[1;6C :TmuxNavigateRight<cr>
nnoremap <silent> <ESC>[1;6D :TmuxNavigateLeft<cr>


" map to the correct key sequence when running in xterm
nnoremap <silent> <C-S-Left>  :TmuxNavigateLeft<cr>
nnoremap <silent> <C-S-Down>  :TmuxNavigateDown<cr>
nnoremap <silent> <C-S-Up>    :TmuxNavigateUp<cr>
nnoremap <silent> <C-S-Right> :TmuxNavigateRight<cr>

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>


" Always show ALE Gutter
let g:ale_sign_column_always = 1


" No bgcolor for ALE SignColumn
highlight clear SignColumn

" ALE Linting Settings
" Erlang linting done via https://github.com/ten0s/syntaxerl
" Download/Build it and put it in your $PATH
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

" Ignorde JS files on CTAGS generation
let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore', '*.js', '*.json', '*.css']

" make uses real tabs
au FileType make set noexpandtab

" Ruby uses 2 spaces
au FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2

" Go uses tabs
au FileType go set noexpandtab tabstop=4 shiftwidth=4

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
au FileType ruby   set softtabstop=2 tabstop=2 shiftwidth=2

" editorconfig.org file manages project specific settings
" disable for fugitve and ssh files
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Use Ag instead of Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" Gitgutter
set updatetime=250

" lightline / Ale

let g:lightline = {
            \ 'colorscheme': 'smyck',
            \ 'component_function' : {
            \   'gitbranch' : 'fugitive#head',
            \ },
    \}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \   'linter_checking': 'left',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left',
      \ }


let g:lightline.active = {
      \   'left' : [ ['mode', 'paste'],
      \              [ 'gitbranch', 'readonly', 'filename', 'modified'  ] ],
      \   'right': [
      \       ['linter_checking',
      \           'linter_errors',
      \           'linter_warnings',
      \           'linter_ok'],
      \       ['lineinfo'],
      \       ['fileformat', 'fileencoding', 'filetype'],
      \   ],
      \ }
