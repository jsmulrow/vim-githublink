" A plugin to create a link to the mongodb/mongo github page corresponding to
" the current file with the selected lines highlighted.
"
" Title: Mongo Github Link
" Author: Jack Mulrow

"
"" Exposed functions.
"

let g:GitHubLinkRepo = "mongodb/mongo"

" Globally set the github repo.
" Defaults to mongodb/mongo
function! SetGithubRepo(repo)
  let g:GitHubLinkRepo = a:repo
endfunction

function! CreateAndCopyGithubLink()
  let l:link = BuildFileLink()

  " Get the line and add it to the link.
  let l:line = line('.')
  let l:link = l:link . '#L' . l:line

  " Copy to clipboard.
  call CopyLinkToClipboard(l:link)

  " Print as well.
  echom l:link
endfunction

function! CreateAndCopyGithubLinkNoLine()
  let l:link = BuildFileLink()

  " Copy to clipboard.
  call CopyLinkToClipboard(l:link)

  " Print as well.
  echom l:link
endfunction

function! CreateAndCopyGithubLinkVisual() range
  let l:link = BuildFileLink()

  if a:firstline == a:lastline
    let l:link = l:link . '#L' . a:firstline
  else
    let l:link = l:link . '#L' . a:firstline . '-L' . a:lastline
  endif

  " Copy to clipboard.
  call CopyLinkToClipboard(l:link)

  " Print as well.
  echom l:link
endfunction

"
"" Helper functions.
"

function! BuildFileLink()
  let l:base = join(['https://github.com/', g:GitHubLinkRepo, '/blob/'], '')
  let l:hash = GetCurrentGitHash()
  let l:path = GetRelativePath()

  return join([l:base, l:hash, '/', l:path], '')
endfunction

function! GetRelativePath()
  " Returns the path to the current file, from the current working directory.
  return expand('%')
endfunction

function! GetCurrentGitHash()
  " Returns the full hash. --short would get the short one.
  return substitute(system('git rev-parse --verify HEAD'), "\n", '\1', '')
endfunction

function! CopyLinkToClipboard(link)
  " Save to the * and + registers.
  let @* = a:link
  let @+ = a:link
endfunction

nnoremap <localleader>gl :call CreateAndCopyGithubLink()<CR>
vnoremap <localleader>gl :call CreateAndCopyGithubLinkVisual()<CR>
