call plug#begin('~/.vim/plugged')
Plug 'kshenoy/vim-signature'
Plug 'scrooloose/nerdcommenter'
Plug 'Chiel92/vim-autoformat'
Plug 'vim-syntastic/syntastic'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
call plug#end()

"===basic===
set nocompatible
syntax enable
filetype plugin on

"===finding files===
":find filename. Press enter to find and open the first matching one. And use tab to list matching files
":ls to list buffers
":b filename then press tab to open the matching buffer file
set path+=**
set wildmenu
set wildignore+=**/node_modules/**
set ic

"===tag===
"- Use ^] to jump
"- Use g^] for ambiguous tags
"- Use ^t to return
"config file ~/.ctags
fun! FindTagsFileInGitDir(file)
	let path = system("git rev-parse --show-toplevel | tr -d '\\n'")
	if stridx(path, "fatal:") >= 0
		let path = fnamemodify(a:file,':h')
	endif
	let cmd = "!ctags -f " . path . "/.tags -R " . path
	echo cmd
	silent exec cmd
endfun
"command! MakeTags !ctags -R .
nnoremap <F11> :call FindTagsFileInGitDir(@%)<CR>
set tags=./.tags;,.tags;
set autochdir

"===autocomplete===
"^n or ^p
"^x^n or ^x^p for just current file
"^x^] to list only in the tags
"^x^f to list only filenames
"imap <TAB> <c-n>
"imap <s-TAB> <c-p>
"inoremap <c-TAB> <TAB>

"===file browsing===
":e foldername
"<CR> to open in horizontal or zip/unzip folder
"v to open in vsplit
"t to open in new tab
"% to create file
"d to create folder
":Lex to open browser
let g:netrw_banner = 0
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
"let g:netrw_list_hide = netrw_gitignore#Hide()
"let g:netrw_list_hide .= ',\(^\|\s\s\)\zs\.\S\+'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
nnoremap <F12> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"snippets
nnoremap ,html :-1read ~/vim/snippets/H5.html<CR>4jwf>a

"===build===
":make to run npm build (what ever you need to build)
":cl to list errors
":cc# jump to error #
":cn and :cp to navigate
"set makeprg = bundle\ exec\ npm\ build
"let &makeprg = "npm run build"

"===copy & paste===
" "+ is the system clipboard
" "+yy copy to system
" "+p paste from system
noremap <Space>y "+yy
noremap <Space>p "+p

"===navigation tabs===
"gt
"gT
"#gt

"===navigation buffers===
"Ctrl + 6, previous file
nnoremap gn :bn<cr>
nnoremap gp :bp<cr>
nnoremap gd :bd<cr>

"===mark===
"mx mark as x
"m, mark next
"m. toggle mark
"]` next mark position
"]' next mark at line start position
"m/ open mark list
"'' jump back
"`1 last file

"===commencing===
"<leader>cc, <leader>cs comments
"<leader>c<space> toggle comments
let mapleader=" "
let g:NERDSpaceDelims = 1

"===format===
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatdef_mz_js = '"js-beautify --indent-with-tabs -n --brace-style collapse-preserve-inline -a -X"'
let g:formatters_javascript = ['mz_js']
noremap <F1> :Autoformat<CR>
au BufWrite * :Autoformat

"===syntax check===
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_args = "--global require,define --parser-options=ecmaVersion:7"
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_include_dirs = ['include','inc']
let g:syntastic_cpp_config_file = '.syntastic_cpp'
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_c_config_file = '.syntastic_cpp'
let g:syntastic_c_check_header = 1
nnoremap <c-j> :ll<CR>
nnoremap <c-k> :lnext<CR>

"===macros===
nnoremap <c-q> q
nnoremap q <Nop>
nnoremap <Space>q @q

"===status line===
":so $VIMRUNTIME/syntax/hitest.vim
set laststatus=2
set statusline=
"set statusline+=%#DiffText#
"set statusline+=%{StatuslineGit()}
set statusline+=%#DiffText#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%#StatusLineTermNC#
set statusline+=\ %f\ 
set statusline+=%#LineNr#
set statusline+=%m\ 
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ [%{&fileformat}\]
set statusline+=%#VertSplit#
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 
function! GitBranch() abort
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction
function! StatuslineGit() abort
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
"hi StatusLineTerm guibg=#ff00ff ctermbg=red
"hi StatusLineNC guibg=#09630c guifg=white ctermbg=green ctermfg=white
"hi StatusLineTermNC guibg=#09630c guifg=white ctermbg=green ctermfg=white

"===miscellaneous===
set nu
set nowrap
set nobackup
set backupcopy=yes
set autoread
set noswapfile
set ignorecase
set nowritebackup
set tabstop=4
set linespace=2
set shiftwidth=4
set encoding=utf-8
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"
set backspace=indent,eol,start
set guifont=FuraMonoNer-Regular:h13

noremap <F2> :%!xxd<CR>
noremap <s-F2> :%!xxd -r<CR>
noremap <F3> <ESC><c-w>]
map <F4> <ESC>:mks!<CR>
map <F5> <ESC>:source Session.vim<CR>
map <F6> <ESC>:split 
map <F7> <ESC>:vsplit 
noremap <F8> <ESC>:cd %:h<CR>
map <s-F9> <ESC>:vertical resize -10<CR>
map <F9> <ESC>:vertical resize +10<CR>
map <s-F10> <ESC>:resize -5<CR>
map <F10> <ESC>:resize +5<CR>
noremap <TAB> <c-w><c-w>
set cursorline
hi cursorline guibg=lightblue