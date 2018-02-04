call plug#begin('~/.vim/plugged')

if !has('nvim')
  Plug 'tpope/vim-sensible'
endif

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'docunext/closetag.vim'
" Plug 'matchit.zip'
Plug 'kien/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pearofducks/ansible-vim'
Plug 'simnalamburt/vim-mundo'
Plug 'junegunn/fzf.vim'

" languages and stuff
" Plug 'ecomba/vim-ruby-refactoring'
Plug 'Keithbsmiley/rspec.vim'
" Plug 'thoughtbot/vim-rspec'
Plug 'ngmy/vim-rubocop'
Plug 'vim-ruby/vim-ruby'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rbenv'
" Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'

" Javascript & React stuff
" Plug 'pangloss/vim-javascript'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'mxw/vim-jsx'
Plug 'othree/yajs.vim'
Plug 'MaxMEllon/vim-jsx-pretty'

" session management
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

" tmux things
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'

call plug#end() " Add plugins to &runtimepath

set mouse+=a
set number
set relativenumber
set laststatus=2
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set textwidth=99
set splitbelow
set splitright
set foldenable
set foldmethod=syntax
set nofoldenable
set wildignore+=.DS_Store,node_modules,*/tmp/*,*.so,*.swp,coverage,tests/roles/*,vendor/bundle
set rtp+=~/.fzf

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.config/nvim/undo

" color and theme
set background=dark
colorscheme Tomorrow-Night

highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" call sudo with w!!
cmap w!! w !sudo tee % >/dev/null

" map leader
let mapleader = ","

" yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" don't mess with wrap movement
nnoremap j gj
nnoremap k gk

" use Esc to hide search highlights
nnoremap <silent> <Esc> :nohlsearch<CR>

" dont use arrow keys :)
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" tab navigation
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>

" syntastic
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" syntastic languages
let g:syntastic_javascript_checkers = ['eslint']

" ctrlp
nmap <silent> <leader>f :FZF<CR>
nmap <silent> <leader>b :CtrlPBuffer<CR>
nmap <silent> <leader>m :CtrlPMRU<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_height = 15
" let g:ctrlp_user_command = {
" 	\ 'types': {
" 		\ 1: ['.git', 'cd %s && git ls-files'],
" 	\ },
" 	\ 'fallback': 'ag -g -l %s'
" \ }
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" fzf emulate ctrlp
nmap <silent> <leader>f :FZF<CR>
nmap <silent> <leader>p :GFiles<CR>
nmap <silent> <leader>h :Helptags<CR>

" window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" terminal navigation
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" search helpers
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" clear fugitive buffers on close
autocmd BufReadPost fugitive://* set bufhidden=delete

" ProSession
let g:prosession_per_branch = 1

" fugitive maps
nmap <silent> <Leader>gs  :Gstatus<CR>
nmap <silent> <Leader>gb  :Gblame<CR>
nmap <silent> <Leader>gl  :Glog -15<CR>
nmap <silent> <Leader>gc  :Gcommit<CR>
nmap <silent> <Leader>ga  :Gcommit --amend<CR>
nmap <silent> <Leader>gm  :Gmove
nmap <silent> <Leader>ge  :Gedit
nmap <silent> <Leader>gr  :Gread<CR>
nmap <silent> <Leader>grm :Gremove<CR>
nmap <silent> <Leader>gd  :Gdiff<CR>
nmap <silent> <Leader>gdv :Gvdiff<CR>
nmap <silent> <Leader>gds :Gsdiff<CR>
nmap <Leader>gg :Ggrep

" vim-test helpers
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" make test commands execute using dispatch.vim
let test#strategy = 'dispatch'

" Use powerline fonts on airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

" tmuxline
let g:tmuxline_powerline_separators = 1
let g:tmuxline_theme = 'airline'
let g:tmuxline_preset = {
  \'a'       : '#S',
  \'win'     : ['#I', '#W'],
  \'cwin'    : ['#I', '#W'],
  \"x"       : '#(tmux show-window-options | grep "synchronize-panes on">/dev/null && echo "Sync")',
  \'y'       : ['%A', '%R'],
  \'z'       : '#H',
  \'options' : {'status-justify' : 'left'}
\}

" promptline
let g:promptline_powerline_symbols = 1
let g:promptline_theme = 'airline'
let g:promptline_preset = {
  \'a'    : [ promptline#slices#cwd({ 'dir_limit': 1 }) ],
  \'b'    : [ promptline#slices#jobs() ],
  \'x'    : [ promptline#slices#git_status(), promptline#slices#vcs_branch() ],
  \'warn' : [ promptline#slices#last_exit_code() ]
\}
let g:promptline_symbols = {
  \'truncation' : 'λ',
\}
