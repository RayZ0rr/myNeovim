local plugins_path = vim.fn.stdpath('data')..'/site/pack/*/start/'
local nnmap = require('options/utils').nnmap
local xnmap = require('options/utils').xnmap

--##########################################################################################################
-- vim floaterm -------------------------------------------------------------------------------------------
--##########################################################################################################
-- vim.g.floaterm_opener = 'edit'
vim.g.floaterm_autoclose = 1
-- nnmap('<leader>tt', [[:execute 'FloatermNew --name=Vifm --disposable vifmrun' fnameescape(getcwd())<CR>]], {remap = false, silent = true})
-- nnmap('<leader>tt', [[<C-\><C-n>:execute 'FloatermToggle Vifm'<CR>]], {remap = false, silent = true})
-- nnmap('<leader>tt', [[:execute 'FloatermToggle Vifm'<CR>]], {remap = false, silent = false})
nnmap('<leader>tr', ':FloatermToggle<CR>', {remap = false, silent = true})
nnmap('<leader>tt', [[:execute 'FloatermNew! --name=Vifm vf'<CR>]], {remap = false, silent = false})
nnmap('<leader>tf', [[:execute 'FloatermNew --name=Vifm vf' fnameescape(getcwd())<CR>]], {remap = false, silent = false})
-- vim.api.nvim_set_keymap('t','<leader>tt', [[<C-\><C-n>:execute 'FloatermToggle Vifm'<CR>]], {remap = false, silent = false})
-- vim.cmd[[autocmd User FloatermOpen nnoremap tt :FloatermToggle<CR>]]
-- vim.api.nvim_set_keymap('t','<leader>tt', [[<C-\><C-n>:execute 'FloatermToggle vifm'<CR>]], {remap = false, silent = true})
-- vim.api.nvim_set_keymap('t','<leader>tr', [[<C-\><C-n>:FloatermToggle<CR>]], {remap = false, silent = true})

vim.cmd([[


command! -nargs=* -complete=customlist,floaterm#cmdline#complete -bang -range
                          \ FloatermCall    call floaterm#run('new', <bang>0, [visualmode(), <range>, <line1>, <line2>], <q-args>)

" vim:sw=2:
" ============================================================================
" FileName: vifm.vim
" Author: kazhala <kevin7441@gmail.com>
" GitHub: https://github.com/kazhala
" ============================================================================

function! VifmFloat(cmd, jobopts, config) abort
  let s:vifm_tmpfile = tempname()
  let original_dir = getcwd()
  lcd %:p:h

  let cmdlist = split(a:cmd)
  let cmd = 'vifm --choose-files "' . s:vifm_tmpfile . '"'
  if len(cmdlist) > 1
    let cmd .= ' ' . join(cmdlist[1:], ' ')
  else
    let cmd .= ' "' . getcwd() . '"'
  endif

  exe "lcd " . original_dir
  let cmd = [&shell, &shellcmdflag, cmd]
  let jobopts = {'on_exit': funcref('s:vifm_callback')}
  call floaterm#util#deep_extend(a:jobopts, jobopts)
  return [v:false, cmd]
endfunction

function! VifmF(job, data, event, opener) abort
  if filereadable(s:vifm_tmpfile)
    let filenames = readfile(s:vifm_tmpfile)
    if !empty(filenames)
      if has('nvim')
        call floaterm#window#hide(bufnr('%'))
      endif
      let locations = []
      for filename in filenames
        if isdirectory(filename)
          exe "cd " . filename
        else
          let dict = {'filename': fnamemodify(filename, ':p')}
          call add(locations, dict)
        endif
      endfor
      if len(locations) != 0
        call floaterm#util#open(locations, a:opener)
      endif
    endif
  endif
endfunction

]])
