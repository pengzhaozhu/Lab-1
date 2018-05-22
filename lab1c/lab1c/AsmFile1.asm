/* Lab 1 Part C
   Name: Pengzhao Zhu
   Section#: 112D
   TA Name: Chris Crary
   Description: This program filters a table in program memory according the several conditions and put the filtered 
                data into data memory
*/

.include "ATxmega128A1Udef.inc"  ;according the Schwartz. The new board/program doesn't need this anymore
.list 

.org 0x0000   ;start at address 0x000
	rjmp MAIN ;jump to main code


.equ temp=((32000000/1024))

.org 0x200  ;a place where we will put our executable code
MAIN:

ldi r16, low(temp)
ldi r17, high(temp)

DONE:
	rjmp DONE