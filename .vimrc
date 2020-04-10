" load sensible defaults here to allow overriding
runtime! plugin/sensible.vim

set nocompatible

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

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

" Autocompletion coc.nvim plugin
" Use tab for trigger completion with characters ahead and navigate.
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
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

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
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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

" Ctrl-P for fzf File view
nnoremap <silent> <C-p> :<C-u>Files<CR><C-p>

" Highlight characters behind the 80 chars margin
:au BufWinEnter * let w:m2=matchadd('ColumnMargin', '\%>80v.\+', -1)

" Highlight Column in lines exceeding the line limit set in .editorconf
let g:EditorConfig_max_line_indicator = "exceeding"

" Disable code folding
set nofoldenable

" Jump to last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" set vim and tmux window switch shortcuts
let g:tmux_navigator_no_mappings = 1

" map xterm key sequences explicitly because tmux uses screen terminal
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
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$', '^venv$', '^__pycache__$', '^tags']
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

" default of 4000ms leads to significant delays
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

" tmuxline


" let g:tmuxline_preset = {
"             \'a'    : '#S',
"             \'win'  : [ '#I', '#W' ],
"             \'cwin' : [ '#I', '#W', '#F' ],
"             \'x'    : "#{network_bandwidth}",
"             \'y'    : ['%R', '%a %b %d'],
"             \'z'    : '#H #{prefix_highlight}',
"             \'options' : {
"             \   'status-justify': 'left'
"             \ }
"             \}

let g:tmuxline_preset = {
            \'a'    : '#S',
            \'win'  : [ '#I', '#W' ],
            \'cwin' : [ '#I', '#W', '#F' ],
            \'y'    : ['%R', '%a %b %d'],
            \'z'    : '#H #{prefix_highlight}',
            \'options' : {
            \   'status-justify': 'left'
            \ }
            \}


let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': "|",
    \ 'right' : '',
    \ 'right_alt' : '|',
    \ 'space' : ' '
    \}
