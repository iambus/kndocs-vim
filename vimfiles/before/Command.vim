
" Created: 2009-01-04 20:55:15
" Last Modified: 2009-01-31 18:07:54

let s:command_dict = {}

" TODO: looks not so good...
function! EvalKeysInString(q)
    return substitute(a:q, '<\w\+>', '\= eval("\"\\".submatch(0)."\"")', 'g')
endfunction

" CommandPut(command, key-sequence, &rest more-key-sequences)
function! CommandPut(...)
  if a:0 < 1
    echoerr 'Too few arguments for CommandPut. Expected: >= 2, got '.a:0.' ('.a:000.'.'
  elseif a:0 == 2
    let s:command_dict[a:1] = a:2
  else
    " join rest 
    let s:command_dict[a:1] = join(a:000[1:])
  endif
endfunction

function! CommandGet(name)
  return s:command_dict[a:name]
endfunction

function! CommandHas(name)
  return has_key(s:command_dict, a:name)
endfunction

" Command(&optional command, &optional key-sequence, &rest more-key-sequences)
function! Command(...)
  if a:0 == 0
    " No argument given, print existing Commands
    for cmd in sort(keys(s:command_dict))
      echo cmd s:command_dict[cmd]
    endfor
  elseif a:0 == 1
    " Only one Command given, print key sequence bound to this Command
    let cmd = a:1
    if CommandHas(cmd)
      echo cmd CommandGet(cmd)
    else
      echo 'No Command found for' cmd
    endif
  else
    " Command and key sequence given, bind Command to key sequence
    " For example, the following will bind Command 'c' to 'k1  k2 k3   k4'
    "   :Command c k1 k2    k3\ \ \ k4
    call CommandPut(a:1, join(a:000[1:]))
  endif
endfunction

function! CommandExecuteString(cmd)
  " FIXME: This is a workaround because command like following doesn't work:
  "
  " :execute 'normal' ":call input('$>')\<cr>"
  "
  " But the following works:
  "
  " :execute "call input('$>')"
  "
  if a:cmd =~ "^:call\\s.*\<cr>$" && a:cmd !~ "\<cr>."
    execute substitute(a:cmd, "^:\\(.*\\)\<cr>$", '\1', '')
  else
    execute 'normal' a:cmd
  endif
endfunction

function! CommandExecute(cmd)
  let cmd = a:cmd
  if CommandHas(cmd)
    let cmd = EvalKeysInString(CommandGet(cmd))
  elseif maparg('\' . cmd) != ""
    let cmd = '\' . cmd
  elseif maparg(',' . cmd) != ""
    let cmd = ',' . cmd
  else
    echoerr "Can't find Command " . cmd
    return
  endif
  call CommandExecuteString(cmd)
endfunction

function! CommandListGet()
  return sort(keys(s:command_dict), 1)
endfunction

function! CommandList(ArgLead, CmdLine, CursorPos)
  return filter(CommandListGet(), "stridx(tolower(v:val), tolower(a:ArgLead)) == 0")
endfunction

function! CommandInput(prompt)
  call inputsave()
  let cmd = input(a:prompt, "", "customlist,CommandList")
  call inputrestore()
  if cmd != ""
    call CommandExecute(cmd)
  endif
endfunction

command! -complete=customlist,CommandList -nargs=* Command call Command(<f-args>)

map <plug>Command :call CommandInput('M-x ')<cr>


