" ================================================================================ 
" Copyright (C) 
" 2015 - Daniel Opitz
" This program is free software; you can redistribute it and/or
" modify it under the terms of the GNU General Public License
" as published by the Free Software Foundation; either version 2
" of the License, or (at your option) any later version.
" 
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with this program; if not, write to the Free Software
" Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
" ================================================================================  



" ================================================== 
" HELPER FUNCTIONS
" ================================================== 
" This function finds the position, where the current argument ends
" The function doesn't move the cursor
function s:FindArgEnd()
  " cache the initial cursor position
  let initpos = getpos('.')
  let done = 0
  while done == 0
    " find the next ',' ')' '<' or '('
    call search(',\|(\|<\|)')
    let c = getline('.')[col('.') - 1]
    " if the current char is an opening bracket '(' or '<'
    " skip to the corresponding closing bracket
    " any other character terminates the search
    if c == '('
      call searchpair('(', '', ')')
    elseif c == '<'
      call searchpair('<', '', '>')
    else
      let done = 1
    endif
  endwhile

  " get the current cursor position and 
  " reset the cursor to its initial position
  let end = getpos('.')
  let end[2] = end[2] - 1
  call setpos('.', initpos)
  return end
endfunction


" This function finds the position, where the current argument begins
" The function doesn't move the cursor
function s:FindArgBeg()
  " cache the initial cursor position
  let initpos = getpos('.')
  let done = 0
  while done == 0
    " reverse find the next ',' '(' '>' or ')'
    call search(',\|)\|>\|(', 'b')
    let c = getline('.')[col('.') - 1]
    " if the current char is a closing bracket ')' or '>'
    " skip to the corresponding opening bracket
    " any other character terminates the search
    if c == ')'
      call searchpair('(', '', ')', 'b')
    elseif c == '>'
      call searchpair('<', '', '>', 'b')
    else
      let done = 1
    endif
  endwhile

  " get the current cursor position and 
  " reset the cursor to its initial position
  let end = getpos('.')
  let end[2] = end[2] + 1
  call setpos('.', initpos)
  return end
endfunction


" This function retrieves the bounds of the 
" function argument the cursor currently resides
function s:FindArgBounds()
  return [s:FindArgBeg(), s:FindArgEnd()]
endfunction



" ================================================== 
" MAIN FUNCTION FOR MARKING FUNCTION ARGS
" ================================================== 
" Marks the argument, where the cursor currently resides in visual mode
function! <SID>FindThisArg()
  let bounds = s:FindArgBounds()
  call setpos("'<", bounds[0])
  call setpos("'>", bounds[1])
  normal! gv
endfunction

" Marks the next argument, where the cursor currently resides in visual mode
function! <SID>FindNextArg()
  " find the end of the current argument and set the cursor position
  let p = s:FindArgEnd()
  call setpos('.', p)
  " check if the ending char is a closing bracket
  " if so, this is the last argument in the function -> cycle back to first
  " if not advance cursor and mark the current argument
  let c = getline('.')[col('.')]
  if (c == ')')
    call searchpair('(', '', ')', 'b')
    normal! l
    call <SID>FindThisArg()
  else
    normal! ll
    call <SID>FindThisArg()
  endif
endfunction


" ================================================== 
" PUBLIC COMMANDS
" ================================================== 
command! -nargs=0 ThisArg :call <SID>FindThisArg()
command! -nargs=0 NextArg :call <SID>FindNextArg()