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

	nnoremap <localleader>gl
	vnoremap <localleader>gl

Using the mapping in normal mode will generate a link to the current line, and
using it in visual mode will link to the selected range of lines.

If you just want a link to the file, manually call `githublink#GetLinkNoLine()`.

Options
------------

There are two configurable options:

	g:githublink#repo
	g:githublink#copyToClipboard

The github repo is automatically detected (by using `git remote get-url origin`
and manipulating the result), but you can override this by setting
`githublink#repo` to whatever string you want to use in the link instead.
To unset this override, call `githublink#UnsetGithubRepo()` (or set
`g:githublink#repo` to an empty string).

	let g:githublink#repo = 'new/repo'
	call githublink#UnsetGithubRepo()

`githublink#copyToClipboard` determines if the link is copied to your clipboard
after being displayed. Defaults to 1. Set to 0 to disable.

	let g:githublink#copyToClipboard = 0
	let g:githublink#copyToClipboard = 1
