
if !exists('g:undotree_WindowLayout')
    let g:undotree_WindowLayout = 2
endif

" auto open diff window
if !exists('g:undotree_DiffAutoOpen')
    let g:undotree_DiffAutoOpen = 0
endif

" if set, let undotree window get focus after being opened, otherwise
" focus will stay in current window.
if !exists('g:undotree_SetFocusWhenToggle')
    let g:undotree_SetFocusWhenToggle = 1
endif

nnoremap <leader>uu :UndotreeToggle<CR>
