\ *********************************************************************
\ FORTH minimal block editor
\    Filename:      editor.4th
\    Date:          21 jul. 2025
\    Modified:      24 jul. 2025
\    File Version:  1.0
\    Copyright:     Marc PETREMANN
\    Author:        Marc PETREMANN
\    GNU General Public License
\ *********************************************************************

16 constant BLOCK_LINES     \ number of lines in block
64 constant LINE_LENGTH     \ line length in a block

\ get addr from line number n in range [0..15]
: @line  ( n -- addr ) 
    LINE_LENGTH * scr @ block + 
  ;

\ display content of line n in current block
: .line  ( n -- )
    @line LINE_LENGTH type
  ;

\ display text "BLK # : nnnn"   where nnnn is block number
: .blk#  ( -- n )
    base @ >r  decimal          
    cr  ." BLK #: " 
    scr @ .
    r> base !
  ;

\ list the content of current block
: l  ( -- )
    .blk#
    BLOCK_LINES 0 do
        cr i 2 .r space 
        [char] | emit space 
        i .line
    loop 
    cr
  ; 

\ go to next block and display content
: n  ( -- )
    1 scr +! l 
  ;

\ go to precedent block and display content
 : p  ( -- )
    -1 scr +! l 
  ;

\ erase content of line n
: e  ( n -- )
    @line LINE_LENGTH bl fill  l
  ;

\ replace content of line n in current block with str
: r  ( n -- <str> )
    >r
    0 word count
    r@ e
    r> @line swap  cmove
    l
  ;


\ Edition HELP
: eHelp  ( -- )
    cr  ."  l   --         display current block content"
    cr  ."  n   --         go to next block and display content"
    cr  ."  p   --         go to precedent block and display content"
    cr  ."  e   n --       erase content of line n in current block"
    cr  ."  r   n -- <str> move <str> in line n in current block"
  ;
