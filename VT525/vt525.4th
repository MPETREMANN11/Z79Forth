\ *********************************************************************
\ ANSI Sequences for VT525 terminal
\    Filename:      vt525.4th
\    Date:          08 oct. 2024
\    Modified:      12 nov. 2024
\    File Version:  1.0
\    System:        Z79Forth
\    Copyright:     Marc PETREMANN
\    Author:        Marc PETREMANN
\    GNU General Public License
\ *********************************************************************

\ ref: https://gist.github.com/halcyon/334da650816876d7be4d1bee8a157f25

\ Some of these definitions come from ESP32Forth or eForth from Brad NELSON
\ and have been adapted

\ go to next line, but not to beginning of next line
: LF ( -- )
    $0A emit
  ;

\ send ESC char
: ESC  ( -- )
    27 emit
  ;

\ Control Sequence Introducer
: CSI ( -- )
    ESC [char] [ emit
  ;

\ send n in string decimal format
: n.  ( n -- )
    base @ decimal swap
    0 U.R
    base !
  ;

\ set general background color in range [0..255]
: bg  ( color -- )
    CSI s" 48;5;" type n. s" m" type
  ;

\ set general foreground color in range [0..255]
: fg  ( color -- )
    CSI s" 38;5;" type n. s" m" type
  ;

\ Position the cursor so that subsequent text output will
\ take place at column x, row y of the display.
\ (column 0, row 0 is the top left-hand corner of the display).
: at-xy ( x y -- )
    1+ swap 1+ swap CSI n. [char] ; emit n. [char] H emit
  ;

\ these definitions are defined by me.

: DECSC  ( -- )         \ Save current cursor position
    ESC [CHAR] 7 emit ;

: DECRC  ( -- )         \ Restore latest saved cursor position
    ESC [CHAR] 8 emit ;

: RIS  ( -- )           \ erases screen
    ESC [CHAR] c emit ;

\ char n ESC: LS2         \ Invoke the G2 Character Set as GL (LS2)
\ char o ESC: LS3         \ Invoke the G3 Character Set as GL (LS3)
\ char \ ESC: LS3R        \ Invoke the G3 Character Set as GR (LS3R)
\ char ) ESC: LS2R        \ Invoke the G2 Character Set as GR (LS2R)
\ char ~ ESC: LS1R        \ Invoke the G1 Character Set as GR (LS1R)

: .chars ( -- ) 256 32 DO i emit loop ;

\ @INFO: these definitions don't work with TERA TERM

\ : DECDWL ( -- )
\     esc ." #3" ;
\
\ : underline
\     CSI ." 4m" ;
\ : reverse
\     CSI ." 7m" ;
\ : blink
\     CSI s" 5m" type ;
