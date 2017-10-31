" A plugin by Jack Mulrow to create a link to the github page corresponding to
" the current file.

function! CreateAndCopyGithubLink()
  " Gather all the parts.
  let l:path = GetRelativePath()
  let l:hash = GetCurrentGitHash()
  let l:lines = GetSelectedLines()

  " Combine them into the link.
  let l:link = CreateLink(l:path, l:hash, l:lines)

  " Copy to clipboard
  call CopyLinkToClipboard(link)

  " Print as well.
  echom l:link
endfunction

function! GetRelativePath()
  " Returns the path to the current file, from the current working directory
  return substitute(expand('%'), "^@", '\1', '')
endfunction

function! GetCurrentGitHash()
  " Returns the full hash. --short would get the short one.
  return system('git rev-parse --verify HEAD')
endfunction

function! GetSelectedLines()
  " Check for visual mode
  " if NOT visual mode
  let l:lines = line('.')
  " else
  "   something
  return l:lines
endfunction

function! CreateLink(path, hash, lines)
  " Start with github link.
  let l:link_builder = 'https://github.com/mongodb/mongo/blob/'

  " Add the hash.
  let l:link_builder = link_builder . a:hash

  " Add the path.
  let l:link_builder = link_builder . a:path
  
  " Add the lines, if given. Lines are optional.
  if a:lines " Should it be a list?
    let l:link_builder = link_builder . '#L' . a:lines
  endif

  return l:link_builder
endfunction

function! CopyLinkToClipboard(link)
  " do something with a:link
  return ""
endfunction

nnoremap <leader>gl :call CreateAndCopyGithubLink()<CR>
vnoremap <leader>gl :call CreateAndCopyGithubLinkVisual()<CR>
