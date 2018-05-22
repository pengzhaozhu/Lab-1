.include "ATxmega128A1Udef.inc"  ;according the Schwartz. The new board/program doesn't need this anymore 
.list  
 
.org 0x0000   ;start at address 0x000  rjmp MAIN ;jump to main code 
	rjmp MAIN

.org 0x7995

Table: .db 0x05, 0x41, 0x83, 0x02, 0x01, 0x00

.dseg
.org 0x2000

filtable: .byte 15 
.equ counter=6

.cseg
.org 0x200

MAIN:
ldi YL, low(filtable)  ;Y pointer point to where the table will start 
ldi YH, high(filtable) ;low and high bytes 

ldi ZL, 0x2A
ldi ZH, 0xF3

TOP:
lpm r16, Z-
lsr r16
st Y+, r16
ldi r18, counter
ldi r17, 0
cp r17, r18
breq DONE
dec r18
rjmp TOP


DONE:
	rjmp DONE




 
 