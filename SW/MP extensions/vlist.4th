\ *********************************************************************
\ VLIST for Z79Forth
\    Filename:      vlist.4th
\    Date:          25 oct. 2024
\    Updated:       31 oct. 2024
\    System:        Z79Forth
\    File Version:  1.0
\    Copyright:     Marc PETREMANN
\    Author:        Marc PETREMANN
\    GNU General Public License
\ *********************************************************************

\ get string for the name of FORTH word from nf address
\ : name>string  ( nf -- addr len )
\     count $1F and
\   ;

\ get lf address from nf address
\ : n>link  ( nf -- lf )
\     \ name>string
\     count $1F and +
\   ;

variable #out       \ store emited characters
70 constant max-out    \ max characters for #out

\ increment #out with emited characters
: #out+!  ( n -- )
    #out +!
    #out @  max-out > if
        cr   0 #out !
    then
  ;

\ display name of a word
: .name  ( nf -- )
    \ name>string
    count $1F and           \ get addr len from nf field
    dup 1+ >r               \ save length+1 to rstack
    type space              \ display name + space
    r> #out+!               \ increment #out, optional CR
  ;

\ display content of current vocabulary
: vlist  ( -- )
    cr   0 #out !           \ initialize emited characters
    last >r
    begin
        r@ .name
        \ r@ n>link @
        r@ count $1F and + @
    while
        \ r> n>link @ >r
        r> count $1F and + @ >r
    repeat
    r> drop
  ;

