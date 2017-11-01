" A plugin to create a link to the github page corresponding to the current
" file, with the selected lines highlighted.
"
" Title: GitHub Link
" Author: Jack Mulrow

"
"" Exposed functions.
"

if !exists("g:githublink#setMapping")
    let g:githublink#setMapping = 1
endif

if !exists("g:githublink#repo")
  let g:githublink#repo = ""
endif

function! githublink#UnsetGithubRepo()
  let g:githublink#repo = ""
endfunction

if !exists("g:githublink#copyToClipboard")
  let g:githublink#copyToClipboard = 1
endif

function! githublink#GetLink()
  let l:link = s:BuildFileLink()

  " Get the line and add it to the link.
  let l:line = line('.')
  let l:link = l:link . '#L' . l:line

  " Copy to clipboard.
  if g:githublink#copyToClipboard
    call s:CopyLinkToClipboard(l:link)
  endif

  " Print as well.
  echom l:link
endfunction

function! githublink#GetLinkNoLine()
  let l:link = s:BuildFileLink()

  " Copy to clipboard.
  if g:githublink#copyToClipboard
    call s:CopyLinkToClipboard(l:link)
  endif

  " Print as well.
  echom l:link
endfunction

function! githublink#GetLinkVisual() range
  let l:link = s:BuildFileLink()

  if a:firstline == a:lastline
    let l:link = l:link . '#L' . a:firstline
  else
    let l:link = l:link . '#L' . a:firstline . '-L' . a:lastline
  endif

  " Copy to clipboard.
  if g:githublink#copyToClipboard
    call s:CopyLinkToClipboard(l:link)
  endif

  " Print as well.
  echom l:link
endfunction

"
"" Helper functions.
"

function! s:BuildFileLink()
  if empty(g:githublink#repo)
    let l:repo = s:GetGithubRepo()
  else
    let l:repo = g:githublink#repo
  endif

  let l:base = join(['https://github.com/', l:repo, '/blob/'], '')
  let l:hash = s:GetCurrentGitHash()
  let l:path = s:GetRelativePath()

  return join([l:base, l:hash, '/', l:path], '')
endfunction

function! s:GetRelativePath()
  " Returns the path to the current file, from the current working directory.
  return expand('%')
endfunction

function! s:GetCurrentGitHash()
  " Returns the full hash. --short would get the short one.
  return substitute(system('git rev-parse --verify HEAD'), "\n", '\1', '')
endfunction

function! s:CopyLinkToClipboard(link)
  " Save to the * and + registers.
  let @* = a:link
  let @+ = a:link
endfunction

" Two expected formats for the origin url.
" https://github.com/jsmulrow/vim-githublink.git
" git@github.com:jsmulrow/vim-githublink.git
function! s:GetGithubRepo()
  let l:origin_url = substitute(system('git remote get-url origin'), "\n", '\1', '')
  let l:pos = match(l:origin_url, 'github.com')
  let l:repo = matchstr(l:origin_url, '[^\\/]\+\/[^\.]\+', l:pos + len('github.com') + 1)
  return l:repo
endfunction

if g:githublink#setMapping
  nnoremap <leader>gl :call githublink#GetLink()<CR>
  vnoremap <leader>gl :call githublink#GetLinkVisual()<CR>
endif
