GitHub Link
=============

Overview
------------

A plugin to get a github link to the selected line(s) at the currently checked
out commit. The link is displayed in vim and by default copied to the clipboard
(by writing to the * and + registers).

Links are in the form:

	https://github.com/<repo>/blob/<commit>/<path_to_file>#<lines>

Assumes your vim working directory is the root of the git repository. If it
isn't, the generated file path will be incorrect.

Also assumes the url of the `origin` remote contains the repo to use in the
link. If this is not the case, see the option `g:githublink#repo` below.

Usage
------------

By default, this plugin sets up two new mappings:

	nnoremap <leader>gl :call githublink#GetLink()<CR>
	vnoremap <leader>gl :call githublink#GetLinkVisual()<CR>

Using the mapping in normal mode will generate a link to the current line, and
using it in visual mode will link to the selected range of lines. To not set
these mappings by default, see the option `g:githublink#setMapping` below.

If you just want a link to the file, manually call `githublink#GetLinkNoLine()`.

Options
------------

There are three configurable options:

	g:githublink#copyToClipboard
	g:githublink#repo
	g:githublink#setMapping

`g:githublink#copyToClipboard` determines if the link is copied to your
clipboard after being displayed. Defaults to 1. Set to 0 to disable.

	let g:githublink#copyToClipboard = 0
	let g:githublink#copyToClipboard = 1

The github repo is automatically detected (by using `git remote get-url origin`
and manipulating the result), but you can override this by setting
`g:githublink#repo` to whatever string you want to use in the link instead.
To unset this override, call `g:githublink#UnsetGithubRepo()` (or set
`g:githublink#repo` to an empty string).

	let g:githublink#repo = 'new/repo'
	call githublink#UnsetGithubRepo()

`g:githublink#setMapping` determines if the default mappings are set when the
plugin is loaded. Defaults to 1. Set to 0 to disable.

	let g:githublink#setMapping = 0
	let g:githublink#setMapping = 1
