"##################################################
" Autocommands
"##################################################

augroup ReloadVIMRCandSettingsGroup
  autocmd!
  au BufWritePost $MYVIMRC nested source $MYVIMRC | echom "Reloaded init.vim"
  " same for this settings file
  au BufWritePost **/settings.vim nested source $MYVIMRC | echom "Reloaded init.vim"
  au BufWritePost **/lua/options/settings.lua nested source $MYVIMRC | echom "Reloaded init.vim"
augroup end

augroup MyCommentsGroup
  autocmd!
  au BufNewFile,BufRead **/.Xresources.d/* setlocal commentstring=!\ %s
  au BufNewFile,BufRead **/.Xresources setlocal commentstring=!\ %s
  autocmd BufNewFile,BufRead /etc/**/*.conf setlocal commentstring=#\ %s
  autocmd FileType xdefaults setlocal commentstring=!\ %s
  autocmd FileType apache setlocal commentstring=#\ %s
  autocmd FileType qf setlocal wrap
  autocmd BufEnter vifmrc setlocal commentstring=\"\ %s
augroup end

autocmd Syntax tmux,py,bash,zsh,sh,r,h,hh,hpp,cc,c,cpp,vim,nvim,lua,xml,html,xhtml,perl normal zR

" au BufRead,BufNewFile *.rasi		setfiletype css
" au BufRead,BufNewFile *.rasi		set commentstring=//\ %s

" Highlight on yank
augroup MyYankHighlightGroup
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

augroup MyCustomSettingsGroup
  autocmd!
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
  au BufWritePre /tmp/*,~/tmp/*,~/.cache/* setlocal noundofile
  " au BufWritePre /tmp/* setlocal noundofile
augroup END

augroup MyTmuxFiletypeDetectGroup
  autocmd!
  au! BufRead,BufNewFile *.tmux		set filetype=tmux | set syntax=sh
  " au! BufRead,BufNewFile *.tmux		set syntax=sh
augroup END

"Remap escape to leave terminal mode
augroup MyTerminalEscapeMappingGroup
  autocmd!
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au TermOpen * set nonu
augroup end

