" Name: krig
" Author: krig
" URL: based on https://github.com/robertmeta/nofrils
" (see this url for latest release & screenshots)
" License: OSI approved MIT license
" Modified: 2019 Apr 13

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "krig"
set background=dark

let s:nord0_gui = "#2E3440"
let s:nord1_gui = "#3B4252"
let s:nord2_gui = "#434C5E"
let s:nord3_gui = "#4C566A"
let s:nord3_gui_bright = "#616E88"
let s:nord4_gui = "#D8DEE9"
let s:nord5_gui = "#E5E9F0"
let s:nord6_gui = "#ECEFF4"
let s:nord7_gui = "#8FBCBB"
let s:nord8_gui = "#88C0D0"
let s:nord9_gui = "#81A1C1"
let s:nord10_gui = "#5E81AC"
let s:nord11_gui = "#BF616A"
let s:nord12_gui = "#D08770"
let s:nord13_gui = "#EBCB8B"
let s:nord14_gui = "#A3BE8C"
let s:nord15_gui = "#B48EAD"

let s:nord1_term = "0"
let s:nord3_term = "8"
let s:nord5_term = "7"
let s:nord6_term = "15"
let s:nord7_term = "14"
let s:nord8_term = "6"
let s:nord9_term = "4"
let s:nord10_term = "12"
let s:nord11_term = "1"
let s:nord12_term = "11"
let s:nord13_term = "3"
let s:nord14_term = "2"
let s:nord15_term = "5"

let s:nord3_gui_brightened = [
  \ s:nord3_gui,
  \ "#4e586d",
  \ "#505b70",
  \ "#525d73",
  \ "#556076",
  \ "#576279",
  \ "#59647c",
  \ "#5b677f",
  \ "#5d6982",
  \ "#5f6c85",
  \ "#616e88",
  \ "#63718b",
  \ "#66738e",
  \ "#687591",
  \ "#6a7894",
  \ "#6d7a96",
  \ "#6f7d98",
  \ "#72809a",
  \ "#75829c",
  \ "#78859e",
  \ "#7b88a1",
  \ ]

function! s:Hi(group, fg, ...)
    " Arguments: group, guifg, guibg, gui, guisp

    let fg = a:fg

    if a:0 >= 1
        let bg = a:1
    else
        let bg = s:none
    endif

    " emphasis
    if a:0 >= 2 && strlen(a:2)
        let emstr = a:2
    else
        let emstr = 'NONE,'
    endif

    let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

    " special
    if a:0 >= 3
        call add(histring, 'guisp=' . a:3[0])
    endif

    execute join(histring, ' ')
endfunction

if !exists("g:krig_strbackgrounds") " {{{
    let g:krig_strbackgrounds = 0
endif " }}}

" Baseline {{{
hi Normal		term=NONE	cterm=NONE	ctermfg=white	ctermbg=black	gui=NONE	guifg=#FFFFFF	guibg=#262626
" }}}

" Faded {{{
hi ColorColumn		term=NONE	cterm=NONE	ctermfg=0	ctermbg=240	gui=NONE	guifg=#000000	guibg=#585858
hi Comment		term=NONE	cterm=NONE	ctermfg=247	ctermbg=NONE	gui=NONE	guifg=#585858	guibg=NONE
hi FoldColumn		term=NONE	cterm=NONE	ctermfg=0	ctermbg=240	gui=NONE	guifg=#000000	guibg=#585858
hi Folded		term=NONE	cterm=NONE	ctermfg=240	ctermbg=NONE	gui=NONE	guifg=#585858	guibg=NONE
"hi LineNr		term=NONE	cterm=NONE	ctermfg=8	ctermbg=235	gui=NONE	guifg=#555555	guibg=#262626
hi NonText		term=NONE	cterm=NONE	ctermfg=240	ctermbg=NONE	gui=NONE	guifg=#585858	guibg=NONE
hi SignColumn		term=NONE	cterm=NONE	ctermfg=240	ctermbg=NONE	gui=NONE	guifg=#585858	guibg=NONE
hi SpecialKey		term=NONE	cterm=NONE	ctermfg=240	ctermbg=NONE	gui=NONE	guifg=#585858	guibg=NONE
hi StatusLineNC		term=NONE	cterm=NONE	ctermfg=white	ctermbg=240	gui=NONE	guifg=#FFFFFF	guibg=#585858
hi VertSplit		term=NONE	cterm=NONE	ctermfg=black	ctermbg=240	gui=NONE	guifg=#000000	guibg=#585858
" }}}

" Highlighted {{{
hi CursorIM		term=NONE	cterm=NONE	ctermfg=0	ctermbg=4	gui=NONE	guifg=#000000	guibg=#00FFFF
hi CursorLineNr		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=0	gui=NONE	guifg=NONE	guibg=#000000
hi CursorLine		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=0	gui=NONE	guifg=NONE	guibg=#000000
hi CursorColumn		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=0	gui=NONE	guifg=NONE	guibg=#000000
hi Cursor		term=NONE	cterm=NONE	ctermfg=0	ctermbg=4	gui=NONE	guifg=#000000	guibg=#00FFFF
hi Directory		term=NONE	cterm=NONE	ctermfg=69	ctermbg=NONE	gui=NONE	guifg=#5F87FF	guibg=NONE
hi ErrorMsg		term=NONE	cterm=NONE	ctermfg=15	ctermbg=52	gui=NONE	guifg=NONE	guibg=#5F0000
hi Error		term=NONE	cterm=NONE	ctermfg=15	ctermbg=52	gui=NONE	guifg=NONE	guibg=#5F0000
hi ModeMsg		term=NONE	cterm=NONE	ctermfg=69	ctermbg=NONE	gui=NONE	guifg=#5F87FF	guibg=NONE
hi MoreMsg		term=NONE	cterm=NONE	ctermfg=69	ctermbg=NONE	gui=NONE	guifg=#5F87FF	guibg=NONE
hi Question		term=NONE	cterm=NONE	ctermfg=69	ctermbg=NONE	gui=NONE	guifg=#5F87FF	guibg=NONE
hi Search		term=NONE	cterm=NONE	ctermfg=0	ctermbg=6	gui=NONE	guifg=#000000	guibg=#00CDCD
hi StatusLine		term=NONE	cterm=NONE	ctermfg=0	ctermbg=15	gui=NONE	guifg=#000000	guibg=#FFFFFF
hi Todo		        term=NONE	cterm=NONE	ctermfg=247	ctermbg=NONE	gui=NONE	guifg=#00FF00   guibg=#000000
hi VisualNOS		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=69	gui=NONE	guifg=NONE	guibg=#5F87FF
hi WarningMsg		term=NONE	cterm=NONE	ctermfg=15	ctermbg=52	gui=NONE	guifg=NONE	guibg=#5F0000
" }}}

" Reversed {{{
hi DiffText		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi IncSearch		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi MatchParen		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi Pmenu		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi TabLineSel		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi Visual		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
hi WildMenu		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
" }}}

" Diff {{{
hi DiffAdd		term=NONE	cterm=NONE	ctermfg=15	ctermbg=22	gui=NONE	guifg=NONE	guibg=#005F00
hi DiffChange		term=NONE	cterm=NONE	ctermfg=15	ctermbg=17	gui=NONE	guifg=NONE	guibg=#00005F
hi DiffDelete		term=NONE	cterm=NONE	ctermfg=15	ctermbg=52	gui=NONE	guifg=NONE	guibg=#5F0000
hi DiffText		term=reverse	cterm=reverse	ctermfg=NONE	ctermbg=NONE	gui=reverse	guifg=NONE	guibg=NONE
" }}}

" Spell {{{
hi SpellBad		term=underline	cterm=underline	ctermfg=13	ctermbg=NONE	gui=underline	guifg=#FF00FF	guibg=NONE
hi SpellCap		term=underline	cterm=underline	ctermfg=13	ctermbg=NONE	gui=underline	guifg=#FF00FF	guibg=NONE
hi SpellLocal		term=underline	cterm=underline	ctermfg=13	ctermbg=NONE	gui=underline	guifg=#FF00FF	guibg=NONE
hi SpellRare		term=underline	cterm=underline	ctermfg=13	ctermbg=NONE	gui=underline	guifg=#FF00FF	guibg=NONE
" }}}

" Vim Features {{{
hi Menu		        term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi PmenuSbar		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi PmenuSel		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi PmenuThumb		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Scrollbar		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi TabLine		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi TabLineFill		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Tooltip		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
" }}}

" Syntax Highlighting (or lack of) {{{
hi Boolean		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Character		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Conceal		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Conditional		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Constant		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Debug		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Define		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Delimiter		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Directive		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Exception		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Float		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Format		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Function		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Identifier		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Ignore		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Include		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Keyword		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Label		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Macro		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Number		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Operator		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi PreCondit		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi PreProc		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Repeat		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi SpecialChar		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi SpecialComment       term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Special		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Statement		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi StorageClass		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi String		term=NONE	cterm=NONE	ctermfg=251	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Structure		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Tag		        term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Title		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Typedef		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Type		        term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
hi Underlined		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=NONE	gui=NONE	guifg=NONE	guibg=NONE
" }}}

" Optional Syntax Features {{{
if g:krig_strbackgrounds
    hi String		term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=233	gui=NONE	guifg=NONE	guibg=#121212
end
" }}}
