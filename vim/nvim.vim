" vim:fdm=marker:fdl=3
" vim options {{{
set number          " Print the line number in front of each line
set relativenumber  " Show the line number relative to the cursor
set hidden          " When off a buffer is unloaded when it is abandoned
set splitbelow      " Put the new window below the current one
set splitright      " Put the new window right of the current one
set lazyredraw      " Do not redrawn while executing commands that have not been typed

let mapleader = ","	" Map `,` to <Leader>

" indentation
set smartindent     " Do smart autoindenting when starting a new line
set autoindent      " Copy indent from current line when starting a new line
set expandtab       " Use the appropriate number of spaces to insert a <Tab>
set tabstop=2       " Number of spaces that a <Tab> in the file counts for
set shiftwidth=2    " Number of spaces to use for each step of (auto)indent
set softtabstop=2   " Number of spaces that a <Tab> counts for in editing operations

" Enable persistent undo so that undo history persists across vim sessions
set undofile

" A comma separated list of options for Insert mode completion
set completeopt=menu

" color and theme
set background=dark
try
  colorscheme Tomorrow-Night
catch /^Vim\%((\a\+)\)\=:E185/
  " deal with it
endtry

" folding
set foldenable
set foldlevel=1
set foldmethod=syntax

highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" ignore stuff
set wildignore+=.git/**,.gitkeep,*.BACKUP.*,*.BASE.*,*.LOCAL.*,*.REMOTE.*
set wildignore+=vendor/**,coverage/**,tmp/**,*/tmp/*,*.so,*.swp,*.zip,log/**
set wildignore+=backup/**,*.sql,*.dump,*.tmp,*.min.js
set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.JPEG,*.jpeg,*.GIF,*.gif,*.pdf,*.PDF
" }}}

" vim mappings {{{
" call sudo with w!!
cmap w!! w !sudo tee % >/dev/null

" yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" don't mess with wrap movement
nnoremap j gj
nnoremap k gk

" dont use arrow keys :)
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" tab navigation
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>

" Copy to system clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y

" Paste from system clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P

" window navigation
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" terminal navigation
tnoremap <Esc> <C-\><C-n>

nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" search helpers
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" }}}

" vim-plug - plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat' " not sure
Plug 'tpope/vim-abolish' " not sure
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" languages and stuff
Plug 'pearofducks/ansible-vim'

" Golang land
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'jodosha/vim-godebug'

" complete and stuff
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

" Function argument completion for Deoplete
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Plug 'fszymanski/deoplete-emoji'

" session management
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install() }}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'edkolev/tmuxline.vim'

Plug 'hashivim/vim-terraform', { 'do': 'make' }

" Initialize plugin system
call plug#end()
" }}}

" fzf {{{
set rtp+=~/Homebrew/opt/fzf
let g:fzf_layout = { 'down': '~20%' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

nmap <silent> <leader>f :FZF<CR>
nmap <silent> <leader>G :GFiles<CR>
nmap <silent> <leader>h :Helptags<CR>

" nnoremap <silent> <Leader>f :Files<CR>
" nnoremap <silent> <Leader>F :Files ~<CR>
" nnoremap <silent> <Leader>b :Buffers<CR>
" nnoremap <silent> <Leader>r :Rg 

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

"" }}}
" airline {{{
" Use powerline fonts on airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
" }}}

 " " deoplete {{{

 " " Enable deoplete when InsertEnter.
 " let g:deoplete#enable_at_startup = 0
 " autocmd InsertEnter * call deoplete#enable()
 " let g:neosnippet#enable_completed_snippet = 1

 " " Plugin key-mappings.
 " " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
 " imap <C-k>     <Plug>(neosnippet_expand_or_jump)
 " smap <C-k>     <Plug>(neosnippet_expand_or_jump)
 " xmap <C-k>     <Plug>(neosnippet_expand_target)

 " " For conceal markers.
 " if has('conceal')
 "   set conceallevel=2 concealcursor=niv
 " endif

 " " Expand the completed snippet trigger by <CR>.
 " imap <expr><CR>
 "   \ (pumvisible() && neosnippet#expandable()) ?
 "   \ "\<Plug>(neosnippet_expand)" : "\<CR>"

 " " SuperTab like snippets behavior.
 " " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
 " imap <expr><TAB>
 "   \ pumvisible() ? "\<C-n>" :
 "   \ neosnippet#expandable_or_jumpable() ?
 "   \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
 " smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 "   \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
 " " }}}
 
 " Golang + vim-go {{{
 let g:go_auto_type_info = 1
 let g:go_autodetect_gopath = 1
 let g:go_fmt_command = "goimports"
 let g:go_list_type = "quickfix"
 let g:go_metalinter_command = "golangci-lint"

 let g:go_highlight_build_constraints = 1
 let g:go_highlight_extra_types = 1
 let g:go_highlight_fields = 1
 let g:go_highlight_functions = 1
 let g:go_highlight_generate_tags = 1
 let g:go_highlight_methods = 1
 let g:go_highlight_types = 1

 augroup go
   autocmd!
   " :GoBuild and :GoTestCompile
   autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
   " :GoTest
   autocmd FileType go nmap <leader>t  <Plug>(go-test)
   " :GoRun
   autocmd FileType go nmap <leader>r  <Plug>(go-run)
   " :GoDoc
   autocmd FileType go nmap <Leader>d <Plug>(go-doc)
   " :GoCoverageToggle
   autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
   " :GoInfo
   autocmd FileType go nmap <Leader>i <Plug>(go-info)
   " :GoDoc as vertical split
   autocmd FileType go nmap K <Plug>(go-doc-vertical)
   " Goto declaration/definition. Results are shown in a vertical split window.
   autocmd FileType go nmap <Leader>g <Plug>(go-def-vertical)
   " :GoMetaLinter
   autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
   " :GoDef but opens in a vertical split
   autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
   " :GoDef but opens in a horizontal split
   autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
   " :GoAlternate  commands :A, :AV, :AS and :AT
   autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
   autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
   autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
   autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
 augroup END

 function! s:build_go_files()
   let l:file = expand('%')
   if l:file =~# '^\f\+_test\.go$'
     call go#test#Test(0, 1)
   elseif l:file =~# '^\f\+\.go$'
     call go#cmd#Build(0)
   endif
 endfunction
 "" }}}

"
"

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
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

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
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

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

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

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

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
