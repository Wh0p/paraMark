# paraMark
Vim plugin for marking c++ style function parameters in visual mode and cycling through them.

The plugin declares 3 functions :ThisArg and :NextArg and :CpyParamList
:ThisArg will mark the function argument under the current cursor position
:NextArg will mark the function argument AFTER the function argument under the current cursor position.
          If the curser is over the last function argument :NextArg cycles back to the first argument.
:CpyParamList <line> will copy the parameter list of the function defined in line <line> from the preview window.
                      This is mainly a hack to fix ycm not printing out the parameterlist and letting tab through
                      function parameters


Configure shortcuts in your .vimrc like
nnoremap <C-A> :ThisArg<CR>
inoremap <C-A> <ESC>:NextArg<CR>
vnoremap <C-A> <ESC>:NextArg<CR>

inoremap <C-D>1 :CpyParamList 1<CR>
inoremap <C-D>2 :CpyParamList 2<CR>
inoremap <C-D>3 :CpyParamList 3<CR>
inoremap <C-D>4 :CpyParamList 4<CR>
inoremap <C-D>5 :CpyParamList 5<CR>
inoremap <C-D>6 :CpyParamList 6<CR>
inoremap <C-D>7 :CpyParamList 7<CR>
inoremap <C-D>8 :CpyParamList 8<CR>
inoremap <C-D>9 :CpyParamList 9<CR>
inoremap <C-D>0 :CpyParamList 10<CR>
