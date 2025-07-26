\ *********************************************************************
\ next block 
\    Filename:      next-block.4th
\    Date:          26 jul. 2025
\    Modified:      26 jul. 2025
\    File Version:  1.0
\    Copyright:     Marc PETREMANN
\    Author:        Marc PETREMANN
\    GNU General Public License
\ *********************************************************************


\ Define size of a block in bytes
1024 CONSTANT B/SCR

\ Display error and end interpreter if word is used out of a block
: ?LOADING  ( -- )
    BLK @ 0=
    IF
        CR ." Use --> only when loading"
        QUIT
    THEN
  ;

\ continue compilation ou interpretation to next block
: -->  ( -- )
    ?LOADING
    BLK @ 1+ LOAD
  ; immediate


