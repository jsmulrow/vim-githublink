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

Usage
------------

By default, this plugin sets up two new mappings:

	nnoremap <localleader>gl
	vnoremap <localleader>gl

Using this mapping in normal mode will generate a link to the current line,
and using it in visual mode will link to the selected range of lines.

If you just want a link to the file, manually call `githublink#GetLinkNoLine()`.

Options
------------

There are two configurable options:

	g:githublink#repo
	g:githublink#copyToClipboard

`githublink#repo` is a string representing the git repository used to make the
link. It defaults to `mongodb/mongo`.

	let g:githublink#repo = 'new/repo'

`githublink#copyToClipboard` determines if the link is copied to your clipboard
after being displayed. Defaults to 1. Set to 0 to disable.

	let g:githublink#copyToClipboard = 0
	let g:githublink#copyToClipboard = 1
