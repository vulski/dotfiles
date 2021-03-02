"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                _
"         __   _(_)_ __ ___  _ __ ___
"         \ \ / / | '_ ` _ \| '__/ __|
"          \ V /| | | | | | | | | (__
"           \_/ |_|_| |_| |_|_|  \___|
" 
"  There are many like it, but this one is mine.
"
"  Sections:
"   -> Dependencies.
"   -> General.
"   -> Syntax, Language specific, auto completion.
"   -> Mappings.
"   -> Editing.
"   -> Text, tab and indent related.
"   -> Colors, Visuals, and Fonts.
"   -> Moving around, tabs, buffers, and splits.
"   -> Autocmd.
"   -> Misc.
"   -> Post plugin load.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ','
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Dependencies
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Universal Ctags
" @see https://askubuntu.com/questions/796408/installing-and-using-universal-ctags-instead-of-exuberant-ctags 

call plug#begin('~/.local/share/nvim/plugged') 
Plug 'SirVer/ultisnips'

Plug 'baverman/vial'
Plug 'baverman/vial-http'
nmap <leader><cr> :VialHttp<cr>

Plug 'elzr/vim-json'

Plug 'neovim/nvim-lspconfig'

Plug 'aklt/plantuml-syntax'
Plug 'scrooloose/vim-slumlord'

Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'rayburgemeestre/phpfolding.vim'

" Languages, snippets
Plug 'vim-test/vim-test'
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#strategy = "neovim"
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

Plug 'stephpy/vim-php-cs-fixer'
Plug 'diepm/vim-php-wrapper' 
Plug 'tobyS/pdv' 
Plug 'tobyS/vmustache'

" Go.
Plug 'fatih/vim-go'

" JavaScript / Vue.js
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
let g:vim_jsx_pretty_colorful_config = 1 

Plug 'sheerun/vim-polyglot'  " Mega syntax pack
Plug 'beyondwords/vim-twig' 
Plug 'jparise/vim-graphql' 

" Editing
Plug 'tpope/vim-commentary'
nmap <C-_> gcc

Plug 'tpope/vim-unimpaired' 
Plug 'Yggdroot/indentLine' " Show line indenations 
Plug 'tpope/vim-surround'

Plug 'jiangmiao/auto-pairs'
let g:AutoPairsFlyMode = 0

" Visuals
Plug 'tpope/vim-fugitive' 
"set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

Plug 'airblade/vim-gitgutter' " Shows git diff for the current file.  
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'nanotech/jellybeans.vim'
Plug 'rakr/vim-one'
Plug 'ajmwagar/vim-deus'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ }
set noshowmode

" Searching
Plug 'mileszs/ack.vim' 
Plug 'skwp/greplace.vim' 
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>F :Tags<CR>
nmap <Leader>a :BTags<CR>
nmap <Leader>A :Ag<CR>

Plug 'tpope/vim-vinegar'

Plug 'scrooloose/nerdtree'
nmap \F :NERDTreeFind 
nmap \e :NERDTreeToggle<CR><C-w>=
let NERDTreeHijackNetrw = 0
let NERDTreeShowHidden = 1

Plug 'mattn/calendar-vim'
Plug 'vimwiki/vimwiki' 
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end
hi link VimwikiHeader1 GruvboxYellowBold
hi link VimwikiHeader3 GruvboxAquaBold
let g:vimwiki_list = [{'auto_tags': 1}]

"Plug 'ludovicchabant/vim-gutentags' 
"let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']

call plug#end()

lua << EOF
require'lspconfig'.tsserver.setup{}
EOF
lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                                    
filetype plugin on

" Marks should go to the column, not just the line. Why isn't this the de
nnoremap ' ` 
set complete=.,w,b,u,t,i,kspell "Set our desired autocompletion matching

set cursorline
"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

set showcmd "Show (partial) command in the status line.  
set magic " For regular expressions turn magic on 
set shortmess+=A            " Don't bother me when a swapfile exists 
set t_vb= " Remove code to flash screen
set tm=500 " Timeout length
set backspace=indent,eol,start " Allow backspace beyond insertion point
set backspace=indent,eol,start " Allow backspace beyond insertion point
set infercase               " Completion recognizes capitalization

set autoread

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax, Language specific, auto completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if hidden is not set, TextEdit might fail.
set hidden 
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup 
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300 
" don't give |ins-completion-menu| messages.
set shortmess+=c 
" always show signcolumns
set signcolumn=yes 

nnoremap <silent> <F5> "=strftime("%m/%d/%y %H:%M:%S")<CR>P
inoremap <silent> <F5> <C-R>=strftime("%m/%d/%y %H:%M:%S")<CR>


" PHP Specific.  
let g:vim_php_refactoring_use_default_mapping = 0
let g:vim_php_refactoring_phpdoc = "pdv#DocumentWithSnip()"
nnoremap  <Leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap  <Leader>rcv :call PhpRenameClassVariable()<CR>
nnoremap  <Leader>rm :call PhpRenameMethod()<CR>
nnoremap  <Leader>eu :call PhpExtractUse()<CR>
vnoremap  <Leader>ec :call PhpExtractConst()<CR>
nnoremap  <Leader>ep :call PhpExtractClassProperty()<CR>
" vnoremap  <Leader>em :call PhpExtractMethod()<CR>
nnoremap  <Leader>np :call PhpCreateProperty()<CR>
nnoremap  <Leader>du :call PhpDetectUnusedUseStatements()<CR>
vnoremap  <Leader>== :call PhpAlignAssigns()<CR>
nnoremap  <Leader>sg :call PhpCreateSettersAndGetters()<CR>
nnoremap  <Leader>cog :call PhpCreateGetters()<CR>
nnoremap  <Leader>da :call PhpDocAll()<CR>

autocmd FileType php setlocal omnifunc=phpactor#Complete
let g:phpactorPhpBin = 'php'
let g:phpactorBranch = 'master'
let g:phpactorOmniAutoClassImport = v:true
let g:phpactorCompletionIgnoreCase = 0
let g:phpactorOmniError = v:true

" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR> 
" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR> 
" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR> 
" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR> 
" Show brief information about the symbol under the cursor
nmap <Leader>K :call phpactor#Hover()<CR> 
" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR> 
" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR> 
" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR> 
" Extract expression from selection
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR> 
" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR> 

let g:php_cs_fixer_rules = '{"@Symfony": true, "binary_operator_spaces": {"align_double_arrow": true, "align_equals": true}, "ordered_imports":true, "array_syntax": {"syntax": "short"}}'
let g:php_cs_fixer_config_file = '$PWD/.php_cs.dist' 
nnoremap <silent><leader>pd :call PhpCsFixerFixDirectory()<CR>zz
nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<CR>zz


"TODO: Fix these binds >.> 
nnoremap <buffer> <silent> <Leader>pck :call VphpwDocClosestMethod(0)<CR>
nnoremap <buffer> <silent> <Leader>cj :call VphpwDocClosestMethod(1)<CR>
noremap  <buffer> <silent> <Leader>cl :call VphpwAlignDocblock()<CR>
nnoremap <buffer> <silent> <Leader>cd :call VphpwDeleteEnclosingDocblock()<CR>
noremap  <buffer> <silent> <Leader>cr :call VphpwResetDocblock()<CR>

let g:pdv_template_dir = $HOME ."/.local/share/nvim/plugged/pdv/templates_snip"
nnoremap  <leader>dm :call pdv#DocumentWithSnip()<CR> 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
inoremap <c-c> <ESC>
nnoremap <silent> <F2> :set relativenumber!<CR> 

"Make it easier to indent a visual selection several times.  
xnoremap > >gv
xnoremap < <gv 

nmap <Leader>ev :e ~/.vimrc<cr> 
nmap <Leader>es :e ~/.vim/snippets/ 
nmap <Leader><space> :nohlsearch<cr>

nmap \x :cclose<cr>
nmap \g :GitGutterToggle<CR>
nmap \r :!tmux send-keys -t bottom C-p C-j <CR><CR>
nmap \z :e! %<CR>

" Auto change directory to match current file ,cd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR> 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
set relativenumber 
set clipboard=unnamedplus 
set number                                              

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr> 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smartcase               " Lets you search for ALL CAPS 
set autoindent              " Auto indents new lines.
set expandtab 
set tabstop=4               " Changes TAB to four spaces
set shiftwidth=4 
set softtabstop=4
set copyindent 
set smarttab 
set lbr
"set textwidth=500
set ignorecase              " Case insensitive
set infercase               " Completion recognizes capitalization
set linebreak               " Break long lines by word, not char 
set nowrap
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax
nnoremap <space> za
vnoremap <space> zf 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors, Visuals, and Fonts.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
colorscheme gruvbox 
set background=dark
let g:gruvbox_italic=1

" True color stuff
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors 

"set laststatus=2 " Always show statusline 

syntax enable 
syn keyword cTodo contained TODO FIXME XXX  

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set nobackup
"set nowb
"set noswapfile 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
set hlsearch
set incsearch
highlight Search cterm=underline

if executable('ag')
      let g:ackprg = 'ag --vimgrep'
endif 

"nnoremap j gj
"nnoremap k gk

nnoremap <C-w>+ 10<C-w>+
nnoremap <C-w>- 10<C-w>- 
nnoremap <C-w>> 10<C-w>>
nnoremap <C-w>< 10<C-w>< 

nnoremap <C-w>k 10<C-w>+
nnoremap <C-w>j 10<C-w>-
nnoremap <C-w>l 10<C-w>>
nnoremap <C-w>h 10<C-w><

nnoremap <C-]> g<C-]> 

" Better tab movement
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" Move between open buffers.
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Automatically write the file when switching buffers.
set autowriteall 
"set scroll=10  

" More natural split opening
set splitbelow
set splitright

" Easy moving between splits
nmap <C-j> <C-W><C-J>
nmap <C-k> <C-W><C-K>
nmap <C-h> <C-W><C-H>
nmap <C-l> <C-W><C-L>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocmd.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Resize panes when window/terminal gets resize
autocmd VimResized * :wincmd =

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif 

"Automatically source the Vimrc file on save."
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

" Remember info about open buffers on close
set viminfo^=% 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" Disable annoying beeps and bells.
set visualbell 
set noerrorbells

" Speedy terminal
set ttyfast
set notimeout
set ttimeout
set ttimeoutlen=100
syntax sync minlines=256
set synmaxcol=500

" An additional vimrc settings file specific to the machine i'm working on.
source ~/.vimrc_specific

"------------Notes and Tips------------" 

"_______ Searching_______
" CTRL + r == fzf :Tags

" <Leader>f == fzf :Tag (quick ctags search)
" CTRL + ], follow into ctag
" :ts == :tagselect
" :tn == :tagnext
" :tp == :tagprevious

" CTRL + 6 == Toggle last and current file

" CTRL + d(down) or u(p) == Scroll up and down
"
" :grep -R something ./ 
" :copen == Quickfix list
"
" :Gsearch == Search for keyboard, (using Ag)
" <change results> :s/From/To
" :Greplace, merges those changes above
" :wa == Write All files

"_____Easy editing________
" J == brings the below line up to the current line
" d(elete) or c(hange) or v(isualize) + i(nside) or a(ll)  + t(ag) or {} or [ ' or " etc

" d(elete) or c(hange) or v(isualize) + s(urround) +  t(ag) or {} or [ ' or etc + replace with (this includes tags, e.g. <span style="">)

" [visual mode] + S<CR> (surround with this, including tags)

" CTRL + a == Increment number
" CTRL + x == Decrement number

" PHP easy editing
" <Leader>n Auto 'use' namespace PHP class

" * and # -- highlight and search current word, # is previous * is next


" {} jump paragraphs, functions
" 0 go to start of line, normal mode
" USE d and c MODIFIERS!

" diw d(elete) i(nside) w(ord)
" Hello List
" ctL [where cursor is on H]
" deletes 'Hello '

" x X, backspace, del, in normal mode

" d{ delete paragraph/function
" d/foo delete foo on next
" d?food delete foo on previous 

" d15j c10k etc etc

" collapse array/list
" V:s/,/,\r/g<enter>

" :<up key>

" :{range}normal {command}
" [range]norm {command}
" 10,20norm A.get('foo')

" :read !wget
": read !wget https://example.com/some/bullshit/json | python -m json.tool

" F5 =strftime("%m/%d/%y %H:%M:%S") 


" [[ go to previous method
" ]] go to next method
" [{ go to start of method 
" ]} go to end of method


" gU[movement]
" go uppercase $ to end of line
" gUw
" 6+ go six lines down to the first none whitespace character
" d]m
" 4$ go to the end of the fouth line down
" g, / g; go back and foward through :changes
" :changes
" CTRL + e
" CTRL + y
" = align
":windo diffthis
":diffoff!
"
" Surround every line with "" and append a ,
":%s/.*/"&",/ 
