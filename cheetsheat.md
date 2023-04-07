# Vim cheat sheet

Vim builtin cheatsheet:

    :help quickref.txt

## Motion [normal mode]

* H - top of screen
* M - middle of screen
* L - bottom of screen
* w - forward to start of word
* e - forward to end of word
* b - backwards to start of word
* ge - backwards to end of word
* % - move to matching character
* 0 - jump to start of line
* ^ - jump to first nonspace character
* $ - jump to end of line
* g_ - jump to last nonblank character
* gg - start of buffer
* G - end of buffer
* gd - local declaration
* gD - global declaration
* [ftFT] - find next/previous character
* ; - repeat previous [ftFT] motion
* , - repeat previous [ftFT] motion backwards
* } - next paragraph/function/block
* { - prev paragraph/function/block
* zz - center cursor on screen
* zt - cursor at top of screen
* zb - cursor at bottom of screen
* ctrl+[ey] - move screen up/down one line
* ctrl+[bf] - move back/forward one screen
* ctrl+[ud] - move back/forward one screen

## Insert mode

* i - insert before cursor
* I - insert at beginning of line
* a - insert after cursor
* A - insert at the end of the line
* o - append new line below current line
* O - append new line above current line
* ea - insert at end of word
* ctrl + h - delete before cursor
* ctrl + w - delete word before cursor
* ctrl + j - begin new line
* ctrl + t - indent line
* ctrl + d - dedent line
* ctrl + rx - insert contents of register x
* ctrl + ox - enter normal mode to issue command x

## Editing

* r - replace character
* R - replace until ESC is pressed
* J - join line below with current
* gwip - reflow paragraph
* gu - lowercase
* gU - uppercase
* cc - change entire line
* C - replace to end of line
* ciw - replace entire word
* cw - replace to end of word
* xp - transpose two letters
* . - repeat last command

## Macros

* qa - record macro a
* q - stop recording macro
* @a - run macro a
* @@ - rerun last run macro

## Cut/paste

* yy - yank line
* yiw - yank inner word
* yaw - yank whole word
* Y - yank to end of line
* p - paste after cursor
* P - paste before cursor
* gp - paste after cursor and leave cursor after new text
* gP - paste before cursor and leave cursor after new text
* dd - delete line

## Marking (visual mode)

* v - start visual mode
* V - start visual mode linewise
* o - move to other end of marked area
* ctrl+v - start visual block mode
* O - move to other corner of block
* aw - mark a word
* ab - a block with ()
* aB - a block with {}
* at - a block with <>

## Visual commands

* > - shift right
* < - shift left
* ~ - switch case
* u - lowercase
* U - uppercase

## Registers and marks
* :reg[isters] - show content of registers
* "xy - yank into register x
* "xp - paste from register x
* "%p - paste current filename
* :marks - list of marks
* ma - set current position as mark a
* \`a - jump to position of mark a
* y\`a - yank text at mark A
* \`. - go to last change in this file
* :ju[mps] - list of jumps
* ctrl+^ - jump to last file
* ctrl+i - next jump list
* ctrl+o - prev jump list
* :changes - list of changes
* g, - newer position in change list
* g; - older position in change list
* ctrl + ] - jump to tag under cursor

## Tabs

* :tabnew - new tab
* ctrl+wT - move current split into its own tab
* gt - next tab
* gT - prev tab
* #gt - goto tab #
* :tabc - close tab
* :tabo - close other tabs
* :tabdo command - run command on all tabs

## Files

* :e file - edit file in new buffer
* :bn - next buffer
* :bp - prev buffer
* :bd - delete buffer
* :b file - go to buffer by file
* :ls - list buffers
* :sp file - split window and open file
* :vs file - vertical split
* :sf - find file in path and edit
* :vert ba - edit all buffers as vertical windows
* :tab ba - edit all buffers as tabs

## Folds

* zf - manually define fold up to motion
* zd - delete fold
* za - toggle fold
* zo - open fold
* zc - close fold
* zr - reduce open folds by one level
* zi - toggle folding

## Editing vim

* :so[urce] % - execute whole buffer
* g ctrl+g - show line, column, word etc at cursor
* g8 - show ASCII code at cursor
* gf - jump to file
* gq - align text to 80 characters
* g?? - rot13 a line


