"##################################################
" Autocommands
"##################################################

augroup reloadVIMRCandSettings
  autocmd!
  au BufWritePost $MYVIMRC nested source $MYVIMRC | echom "Reloaded init.vim"
  " same for this settings file
  au BufWritePost **/settings.vim nested source $MYVIMRC | echom "Reloaded init.vim"
  au BufWritePost **/lua/options/settings.lua nested source $MYVIMRC | echom "Reloaded init.vim"
augroup end

augroup myCommentsGroup
  autocmd!
  autocmd FileType apache setlocal commentstring=#\ %s
  autocmd FileType xdefaults setlocal commentstring=!\ %s
  autocmd BufEnter vifmrc setlocal commentstring=\"\ %s
  autocmd FileType qf setlocal wrap
augroup end

autocmd Syntax tmux,py,bash,zsh,sh,r,h,hh,hpp,cc,c,cpp,vim,nvim,lua,xml,html,xhtml,perl normal zR

" au BufRead,BufNewFile *.rasi		setfiletype css
" au BufRead,BufNewFile *.rasi		set commentstring=//\ %s

" Highlight on yank
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

augroup noUndoFiles
  autocmd!
  au BufWritePre /tmp/* setlocal noundofile
augroup END

augroup tmuxFiletypeDetect
  autocmd!
  au! BufRead,BufNewFile *.tmux		set filetype=tmux | set syntax=sh
  " au! BufRead,BufNewFile *.tmux		set syntax=sh
augroup END

"Remap escape to leave terminal mode
augroup TerminalEscapeMapping
  autocmd!
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au TermOpen * set nonu
augroup end

