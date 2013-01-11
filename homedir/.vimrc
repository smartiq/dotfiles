set ts=3
set shiftwidth=3
set showmatch
set ignorecase
set smartcase
set title
set undolevels=100
set expandtab
set autoindent
set splitbelow
set splitright
set hlsearch
set background=dark
set incsearch
set cindent
set number
set wildmode=longest,list

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
"set wrap
set textwidth=79
set colorcolumn=+1
set formatoptions=qrn1

"Trailing whitespace should be red:
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

cabbr %% <C-R>=expand('%:p:h')<CR>

syntax on
filetype on
nnoremap <silent> <F8> :TlistToggle<CR>
map <F12> :!/usr/bin/ctags -R --extra=+q .;/usr/bin/cscope -R -b<CR>
let Tlist_WinWidth = 40
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_Process_file_Always = 1
let Tlist_Show_One_File = 1

command Co !ct co -nc %:p<CR>

au BufRead,BufNewFile *.dbinfo setfiletype sql
au BufRead,BufNewFile *.function setfiletype sql
au BufRead,BufNewFile *.trigger setfiletype sql
au BufRead,BufNewFile *.sel setfiletype php
au BufRead,BufNewFile *.gv setfiletype dot
au BufRead,BufNewFile scratch set nonumber

" Linux Kernel Coding
"set noexpandtab                         " use tabs, not spaces
"set tabstop=8                           " tabstops of 8
"set shiftwidth=8                        " indents of 8
"set textwidth=78                        " screen in 80 columns wide, wrap at 78
"set autoindent smartindent              " turn on auto/smart indenting
"set smarttab                            " make <tab> and <backspace> smarter
"set backspace=eol,start,indent          " allow backspacing over indent, eol, & start

" Dont jump to first column for # in python
"autocmd BufRead *.py inoremap # <c-h> #
autocmd FileType make setlocal noexpandtab

augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
      \ if expand("<afile>:p:h") !=? $TEMP |
      \   if line("'\"") > 1 && line("'\"") <= line("$") |
      \     let JumpCursorOnEdit_foo = line("'\"") |
      \     let b:doopenfold = 1 |
      \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
      \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
      \        let b:doopenfold = 2 |
      \     endif |
      \     exe JumpCursorOnEdit_foo |        
      \   endif |
      \ endif
      " Need to postpone using "zv" until after reading the modelines. 
    autocmd BufWinEnter *
      \ if exists("b:doopenfold") |
      \   exe "normal zv" |
      \   if(b:doopenfold > 1) |
      \      exe "+".1 |
      \   endif |
      \   unlet b:doopenfold |
      \   endif
        
