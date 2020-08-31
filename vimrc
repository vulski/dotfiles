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

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'aklt/plantuml-syntax'
Plug 'scrooloose/vim-slumlord'

Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'rayburgemeestre/phpfolding.vim'

" Languages, snippets
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
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

Plug 'airblade/vim-gitgutter' " Shows git diff for the current file.  
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'rakr/vim-one'
Plug 'ajmwagar/vim-deus'

" Searching

Plug 'mileszs/ack.vim' 

Plug 'skwp/greplace.vim' 
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
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

Plug 'vimwiki/vimwiki' 
hi link VimwikiHeader1 GruvboxYellowBold
hi link VimwikiHeader3 GruvboxAquaBold

Plug 'ludovicchabant/vim-gutentags' 
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']

call plug#end()


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

let autoreadargs={'autoread':1} 

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

" CoC Garbage 
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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
let g:gruvbox_italic=1

" True color stuff
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors 

set laststatus=2 " Always show statusline 

syntax enable 
set background=dark
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
