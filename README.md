# paraMark
Vim plugin for marking c++ style function parameters in visual mode and cycling through them.

The plugin declares 2 functions :ThisArg and :NextArg
:ThisArg will mark the function argument under the current cursor position
:NextArg will mark the function argument AFTER the function argument under the current cursor position.
          If the curser is over the last function argument :NextArg cycles back to the first argument.

Configure shortcuts in your .vimrc like
nnoremap <C-A> :ThisArg<CR>
nnoremap <C-N> :NextArg<CR>
vnoremap <C-N> <ESC>:NextArg<CR>
