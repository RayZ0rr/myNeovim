" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1
" set syntax=css
" so $VIMRUNTIME/syntax/css.vim
" au BufRead,BufNewFile *.rasi		setfiletype css
" au FileType rasi		setfiletype css
setlocal commentstring=//\ %s
" command echom "rasi ftplugin read"
