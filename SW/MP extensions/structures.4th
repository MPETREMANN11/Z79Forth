\ *********************************************************************
\ Structures C-like in Forth
\    Filename:      structures.4th
\    Date:          03 oct. 2024
\    Updated:       09 oct. 2024
\    System:        Z79Forth
\    File Version:  1.0
\    Copyright:     Marc PETREMANN
\    Author:        Marc PETREMANN
\    GNU General Public License
\ *********************************************************************

\ adapted from structures in ESP32Forth / eForth from Brad NELSON

\ Usage:
\ 
\ struct   comp: -- <struct-name> | exec: -- n
\ Define a new structure named <struct-name>. 
\ The execution of <struct-name> push the size of defined structure. Example:
\   struct string
\ 
\ fiels    comp: type -- <field-name> | exec: addr -- addr'
\ Define a new field named <field-name> in current structure.
\ The execution of <field-name> increment the initial address of a data structure
\ to the real address pointed by this field. Example:
\   byte field ->size
  

\ store parameter address of latest defined structure
0 value last-struct

\ Define a new structure
: struct ( comp: -- <name> | -- n )
    create
        0 ,                     \ initial value
        last count + 2 + 
        >body to last-struct    \ store param. addr in last-struct
    does>
        @
  ;

\ Define a data type in tructure
: typer ( len -- )
    constant
  ;

1 typer char
1 typer byte
2 typer int
4 typer double
1 typer i8
2 typer i16
4 typer i32

\ Define a fild in data structure
: field ( comp: c -- | exec: addr -- addr' )
    create
        dup
        last-struct @ ,     \ get and compile latest position in structure
        last-struct +!      \ increment latest structure
    does> 
        @ +                 \ get real position of data in structure
  ;

\ example:

struct dateTime
    int field ->year
   byte field ->month
   byte field ->day
   byte field ->hour
   byte field ->min
   byte field ->sec

create currentDate 
    dateTime allot

    2024 currentDate ->year !
      10 currentDate ->month c!
      09 currentDate ->day c!
      17 currentDate ->hour c!
      15 currentDate ->min c!
      00 currentDate ->sec c!

    currentDate ->min c@ .   \ display 15
