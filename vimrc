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
let g:UltiSnipsExpandTrigger = "<Nop>"
let g:UltiSnipsListSnippets = "<Nop>"

Plug 'baverman/vial'
Plug 'baverman/vial-http'
nmap <leader><cr> :VialHttp<cr>

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

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

" Go.
Plug 'fatih/vim-go'

" Editing
Plug 'tpope/vim-commentary'
nmap <C-_> gcc

Plug 'tpope/vim-unimpaired' 
Plug 'Yggdroot/indentLine' " Show line indenations 
Plug 'tpope/vim-surround'

Plug 'jiangmiao/auto-pairs'
let g:AutoPairsFlyMode = 0

" Visuals
Plug 'airblade/vim-gitgutter' " Shows git diff for the current file.  
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'

" Searching
Plug 'mileszs/ack.vim' 
Plug 'skwp/greplace.vim' 
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

Plug 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>F :Tags<CR>
nmap <Leader>a :BTags<CR>
nmap <Leader>A :Ag<CR>

Plug 'junegunn/goyo.vim'

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
set updatetime=100 
" don't give |ins-completion-menu| messages.
set shortmess+=c 
" always show signcolumns
set signcolumn=yes 

nnoremap <silent> <F5> "=strftime("%m/%d/%y %H:%M:%S")<CR>P
inoremap <silent> <F5> <C-R>=strftime("%m/%d/%y %H:%M:%S")<CR>


" PHP Specific.  
let g:php_cs_fixer_rules = '{"@Symfony": true, "binary_operator_spaces": {"align_double_arrow": true, "align_equals": true}, "ordered_imports":true, "array_syntax": {"syntax": "short"}}'
let g:php_cs_fixer_config_file = '$PWD/.php_cs.dist' 
nnoremap <silent><leader>pd :call PhpCsFixerFixDirectory()<CR>zz
nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<CR>zz


let g:pdv_template_dir = $HOME ."/.local/share/nvim/plugged/pdv/templates_snip"
nnoremap  <leader>dm :call pdv#DocumentWithSnip()<CR> 

" CoC 
let g:coc_global_extensions = ['coc-solargraph']
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
nmap <A-r> <Plug>(coc-rename)

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
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
nnoremap <silent> <F2> :set relativenumber!<CR> 

"Make it easier to indent a visual selection several times.  
xnoremap > >gv
xnoremap < <gv 

nmap <Leader>ev :e ~/.vimrc<cr> 
nmap <Leader>es :e ~/.vim/snippets/ 
nmap <Leader><space> :nohlsearch<cr>

nmap \x :cclose<cr>
nmap \g :GitGutterToggle<CR>
nmap \G :GitGutterLineHighlightsToggle<CR>
command! Gqf GitGutterQuickFix | copen
nmap \r :!tmux send-keys -t bottom C-p C-j <CR><CR>
nmap \z :e! %<CR>

" Auto change directory to match current file ,cd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR> 

" Move lines up and down with ctrl-alt+j,k
nnoremap <C-A-j> :m .+1<CR>==
nnoremap <C-A-k> :m .-2<CR>==
inoremap <C-A-j> <Esc>:m .+1<CR>==gi
inoremap <C-A-k> <Esc>:m .-2<CR>==gi
vnoremap <C-A-j> :m '>+1<CR>gv=gv
vnoremap <C-A-k> :m '<-2<CR>gv=gv

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>


" jk | Escaping!
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

" Zoom
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" qq to record, Q to replay
nnoremap Q @q


" Quickfix
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" <tab> / <s-tab> | Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

nnoremap <leader>c :cclose<bar>lclose<cr>

" #!! | Shebang
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

" ----------------------------------------------------------------------------
" <F5> / <F6> | Run script
" ----------------------------------------------------------------------------
function! s:run_this_script(output)
  let head   = getline(1)
  let pos    = stridx(head, '#!')
  let file   = expand('%:p')
  let ofile  = tempname()
  let rdr    = " 2>&1 | tee ".ofile
  let win    = winnr()
  let prefix = a:output ? 'silent !' : '!'
  " Shebang found
  if pos != -1
    execute prefix.strpart(head, pos + 2).' '.file.rdr
  " Shebang not found but executable
  elseif executable(file)
    execute prefix.file.rdr
  elseif &filetype == 'ruby'
    execute prefix.'/usr/bin/env ruby '.file.rdr
  elseif &filetype == 'tex'
    execute prefix.'latex '.file. '; [ $? -eq 0 ] && xdvi '. expand('%:r').rdr
  elseif &filetype == 'dot'
    let svg = expand('%:r') . '.svg'
    let png = expand('%:r') . '.png'
    " librsvg >> imagemagick + ghostscript
    execute 'silent !dot -Tsvg '.file.' -o '.svg.' && '
          \ 'rsvg-convert -z 2 '.svg.' > '.png.' && open '.png.rdr
  else
    return
  end
  redraw!
  if !a:output | return | endif

  " Scratch buffer
  if exists('s:vim_exec_buf') && bufexists(s:vim_exec_buf)
    execute bufwinnr(s:vim_exec_buf).'wincmd w'
    %d
  else
    silent!  bdelete [vim-exec-output]
    silent!  vertical botright split new
    silent!  file [vim-exec-output]
    setlocal buftype=nofile bufhidden=wipe noswapfile
    let      s:vim_exec_buf = winnr()
  endif
  execute 'silent! read' ofile
  normal! gg"_dd
  execute win.'wincmd w'
endfunction
" nnoremap <silent> <F5> :call <SID>run_this_script(0)<cr>
nnoremap <silent> <F6> :call <SID>run_this_script(1)<cr>

" <F8> | Color scheme selector
function! s:colors(...)
  return filter(map(filter(split(globpath(&rtp, 'colors/*.vim'), "\n"),
        \                  'v:val !~ "^/usr/"'),
        \           'fnamemodify(v:val, ":t:r")'),
        \       '!a:0 || stridx(v:val, a:1) >= 0')
endfunction

function! s:rotate_colors()
  if !exists('s:colors')
    let s:colors = s:colors()
  endif
  let name = remove(s:colors, 0)
  call add(s:colors, name)
  execute 'colorscheme' name
  redraw
  echo name
endfunction
nnoremap <silent> <F8> :call <SID>rotate_colors()<cr>

" XXX: Check this out later
" :Shuffle | Shuffle selected lines
function! s:shuffle() range
ruby << RB
  first, last = %w[a:firstline a:lastline].map { |e| VIM::evaluate(e).to_i }
  (first..last).map { |l| $curbuf[l] }.shuffle.each_with_index do |line, i|
    $curbuf[first + i] = line
  end
RB
endfunction
command! -range Shuffle <line1>,<line2>call s:shuffle()

" ----------------------------------------------------------------------------
" call LSD()
" ----------------------------------------------------------------------------
function! LSD()
  syntax clear

  for i in range(16, 255)
    execute printf('highlight LSD%s ctermfg=%s', i - 16, i)
  endfor

  let block = 4
  for l in range(1, line('$'))
    let c = 1
    let max = len(getline(l))
    while c < max
      let stride = 4 + reltime()[1] % 8
      execute printf('syntax region lsd%s_%s start=/\%%%sl\%%%sc/ end=/\%%%sl\%%%sc/ contains=ALL', l, c, l, c, l, min([c + stride, max]))
      let rand = abs(reltime()[1] % (256 - 16))
      execute printf('hi def link lsd%s_%s LSD%s', l, c, rand)
      let c += stride
    endwhile
  endfor
endfunction

" ----------------------------------------------------------------------------
" :A
" ----------------------------------------------------------------------------
function! s:a(cmd)
  let name = expand('%:r')
  let ext = tolower(expand('%:e'))
  let sources = ['c', 'cc', 'cpp', 'cxx']
  let headers = ['h', 'hh', 'hpp', 'hxx']
  for pair in [[sources, headers], [headers, sources]]
    let [set1, set2] = pair
    if index(set1, ext) >= 0
      for h in set2
        let aname = name.'.'.h
        for a in [aname, toupper(aname)]
          if filereadable(a)
            execute a:cmd a
            return
          end
        endfor
      endfor
    endif
  endfor
endfunction
command! A call s:a('e')
command! AV call s:a('botright vertical split')

" ----------------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------------
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()

" ----------------------------------------------------------------------------
" <Leader>?/! | Google it / Feeling lucky
" ----------------------------------------------------------------------------
function! s:goog(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>
xnoremap <leader>? "gy:call <SID>goog(@g, 0)<cr>gv
xnoremap <leader>! "gy:call <SID>goog(@g, 1)<cr>gv

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
set wrap
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax
nnoremap <space> za
vnoremap <space> zf 

map <F7> gg=G<C-o><C-o>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors, Visuals, and Fonts.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
colorscheme nord 
set background=dark
let g:gruvbox_italic=1

" True color stuff
if !has('gui_running')
  set t_Co=256
endif

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

" Make it easier to move through wrapped lines.
nnoremap j gj
nnoremap k gk

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
"autocmd VimResized * :wincmd =

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
